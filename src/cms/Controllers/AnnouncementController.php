<?php 

namespace Orbs\Controllers;

use Orbs\Models\Annoucement;
use Orbs\Models\FileManager as File;
use PDOException;
use Helper;
use Dflydev\ApacheMimeTypes\PhpRepository as MimeType;


/**
 * Widget Controller
 *
 * @package Orbs Solutions
 */
class AnnouncementController extends Controller {

    public function showAnnouncements($req, $res, $args) {
        $tmpl = 'admin/announcement/all.twig';
        $announcements = ''; // (new Announcement)->getAllAnnouncements();
        $error = $this->segment->getFlash('error');
        $ctx = [
            'annoucements' => $annoucements,
            'error' => $error,
        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

    public function getAnnouncementForm($req, $res, $args) {
        $tmpl = 'admin/announcement/create.twig';
        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');

        $ctx = [
            'errors' => $errors,
            'error' => $error,
            'success' => $success,
            'old' => $old,
        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

      public function postAnnouncmentForm($req, $res, $args) {

        $ancModel = new Announcement;
        $fileModel = new File;

        $requiredFields = ['name', 'date', 'content'];
        $uniqueFields = ['name'];

        $data = $req->getParsedBody();

        $uploadDir = file_exists("uploads/files/") ? "uploads/files/" : mkdir("uploads/files/", 0777, true);
        $thumbDir  = $uploadDir . "thumbs/";
        if(!is_dir($thumbDir)) {
            mkdir($thumbDir,0777);
            chmod($thumbDir,0777);
        }

        $maxSize = ( 5 * 1024 * 1024 ); // 5mb
        $file = $req->getUploadedFiles()['upload'];
        
        /***************************************
        * validation                          *
        **************************************/
        $errors = [];
        $failureRedirectRoute = '/admin/announcement/create';
        $successRedirectRoute = '/admin/announcement';

        if ($file == null) {
            $errors['none'] = 'The uploaded file is not accepted.';
        }
        if ($file->getError() == 4) {
            $errors['nofile'] = 'No file is selected for upload';
        }

        $fileSize = $file ? $file->getSize() : 0;
        if ($maxSize - $fileSize < 0) {
            $errors['size'] = 'The file size is too large, uploads must be less than 5mb';
        }

       
        $this->segment->setFlash('old', $data);

        foreach ($requiredFields as $required) {
            if (empty($data[$required]) || ! isset($data[$required])) {
                $errors[$required] = "Field is required";
            }
        }
        $nameExists = $ancModel->nameExists($data['name']);
        if ($nameExists) {
            $errors['unique'] = 'Name already exists.';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        // validate or fillable fields
        $validFields = [];
        $validFields['content'] = $data['content'];
        $validFields['date'] = $data['date'];        
        $validFields['name'] = $data['name'];
        $validFields['label'] = Helper::toUrl($data['name']);
        
        // image metadata
        $fileInfo = pathinfo($file->getClientFileName());
        $extension = $fileInfo['extension'];
        $filename = Helper::genRandom_uuid() . '.' . $extension; // random name 
        $fileUrl = $uploadDir . $filename; // filepath is the file itself 
        $thumbnail =   $thumbDir . $filename; // thumbnail
        $fileSize = $file ? $file->getSize() : 0;
        $humanSize = Helper::human_fileSize($fileSize);
        $fileType = $file->getClientMediaType();
        $fileType = (new MimeType)->findExtensions($fileType)[0];
        // ['size', 'url', 'name', 'type']
        $imageData = [
            'size' => $humanSize,
            'url' => $filename, 
            'name' => Helper::toUrl($data['name']), // name of the inventory item
            'type' => $fileType,
        ];

        try {

            $file->moveTo($fileUrl);

            copy($fileUrl , $thumbnail);
            chmod($fileUrl, 0777);
            chmod($thumbnail, 0777);
            $myimage =  getimagesize($thumbnail);
            $width   =  $myimage[0];
            $height  =  $myimage[1];
            $type    =  $myimage[2];

            $resize = 150;
            if($width > $resize){
                $scale=$resize/$width;
                $this->resizeImage($thumbnail, 0, 0, $width, $height, $scale, $type);
            }
            else{
                $scale=1;
                $this->resizeImage($thumbnail, 0, 0, $width, $height, $scale, $type);                    
            }
            
            $isUploaded = true;

        } catch (Exception $e) { // catches a thrown error (RuntimeException precisely)
            $isUploaded = false;
        }

        if (! $isUploaded) {
            $this->segment->setFlash('error', 'Something went wrong');
            return $res->withRedirect($failureRedirect);
        }

        try {
            $this->db->beginTransaction();

            $widgetType = 1;
            $widgetModel->createAWidget($validFields, $widgetType);
            $fileModel->createFile($imageData);
            $this->db->commit();
            $done = true;

        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }

        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($failureRedirectRoute);
        }

        $this->segment->setFlash('success', 'Inventory Created successfully');
        return $res->withRedirect($successRedirectRoute);
       
    }

    
}
