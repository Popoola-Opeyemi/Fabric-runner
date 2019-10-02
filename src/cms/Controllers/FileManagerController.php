<?php 

namespace Orbs\Controllers;

use Orbs\Models\FileManager as File;
use Helper;
use Exception;
use Dflydev\ApacheMimeTypes\PhpRepository as MimeType;
use Orbs\Models\Gallery;

class FileManagerController extends Controller {

    public function postUploadFile($req, $res, $args) {
        $failureRedirect = '/admin/files/create';
        $successRedirect = '/admin/files';
        
        $fileDir = file_exists("uploads/files/") ? "uploads/files/" : mkdir("uploads/files/", 0777, true);
        $fileModel = new File; 
        
    
        
        $uploadDir = null;
        $maxSize = (5 * 1024 * 1024); // 5 mb 
        // file and filename 
        $file = $req->getUploadedFiles()['upload'];
        $file_name = $req->getParam('file_name');

        $payload = [];
        $errors = [];
    
        /*************************************
         *            VALIDATIONS            *
         *************************************/
         // errors list -> ('file_name', 'none', 'nofile', 'size', 'unique');
        if ($file_name == null) {
            $errors['file_name'] = 'The name field is required';
        }
        if ($fileModel->fileNameExists($file_name)) {
            $errors['unique'] = 'This file name already exists';
        }
        if ($file == null) {
            $errors['none'] = 'The uploaded file is not accepted.';
        }
        // get file size whence file is not null
        $fileSize = $file ? $file->getSize() : 0;
        
        if ($file->getError() == 4) {
            $errors['nofile'] = 'No file is selected for upload';
        }
        if ($maxSize - $fileSize < 0) {
            $errors['size'] = 'The file size is too large, uploads must be less than 5mb';
        }

        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirect);
        }
            
        // ===> file size 
        $fileInfo = pathinfo($file->getClientFileName());
        $extension = $fileInfo['extension'];
        $pathinfo = pathinfo($file->getClientFileName());

        //  ===> file type 
        $fileType = $file->getClientMediaType();
        $type = (new MimeType)->findExtensions($fileType)[0];
        
        if (preg_match('/image\/*/', $type)) { 
            $uploadDir = $imageDir;
        } else {
            $uploadDir = $fileDir;
        }
        
        $filename = Helper::genRandom_uuid() . '.' . $extension;
        $fileUrl = $uploadDir . $filename;
        
        $size = Helper::human_fileSize($fileSize);

        $payload = [
            'size' => $size,
            'url' => $filename,
            'name' => $file_name,
            'type' => $type,
        ];
        // ensure file is uploaded before persisting metadata to db 
        try {
            $file->moveTo($fileUrl);
            $this->db->beginTransaction();
            $fileModel->createFile($payload);
            $this->db->commit();
            $done = true;
        } catch (Exception $e) { 
            $error = $e->getMessage();
            $done = false;
        } catch (PDOException $e) {
            $error = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
  
        if (! $done) {
            $this->segment->setFlash('error', 'Something went wrong, please try again');
            return $res->withRedirect($failureRedirect);
        }
        $this->segment->setFlash('success', 'File successfully uploaded');
        return $res->withRedirect($successRedirect);
                    
    }

    public function getUploadFile($req, $res, $args) {
        
        $tmpl = 'admin/fileManager/create.twig';
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors');
        
        $ctx = [
            'error' => $error,
            'errors' => $errors,
        ];
        
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

    public function getFileManager($req, $res, $args) {

        $tmpl = 'admin/fileManager/all.twig';
        $fileModel = new File;

        $error = $this->segment->getFlash('error');
        $images = $fileModel->getImages();
        
        $ctx = [
            'error' => $error,
            'images' => $images,
        ];
        
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

    /** 
     * Delete only files not in use
     */
    public function deleteFile($req, $res, $args) {
        $fileModel = new File;
        $id = $args['id'];
        // check that file is not in use -> then delete 
        if ($fileModel->isFileInUse($id)) {
            return $res->withJson(['in_use' => true,'message' => 'Cannot delete a file in use',]);
        }
        $url = $fileModel->getFileById($id)['url'];
        $dir = 'uploads/files/';
        $fileDir = $dir . $url;
        $done = $fileModel->deleteFile($id);
        if (! $done) {
            return $res->withJson(['error' => 'Something went wrong, please try again later',]);
        }
        unlink($fileDir); 
        return $res->withJson(['is_deleted' => true]);
    }
 
    public function getUpdateFile($req, $res, $args) {
        $fileModel = new File;
        $editTemplate = 'admin/fileManager/edit.twig';
        $id = (int)$args['id'];
        $file = $fileModel->getFileById($id);
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors');
        $ctx = [
            'file' => $file,
            'error' => $error,
            'errors' => $errors,
        ];
        $response = $this->view->render($res, $editTemplate, $ctx);
        return $response;
    }

    public function postUpdateFile($req, $res, $args) {

        $id = $args['id'];
        $failureRedirect = "/admin/files/edit/$id";
        $successRedirect = '/admin/files';
        
        $fileDir  = file_exists("uploads/files/")  ? "uploads/files/"  : mkdir("uploads/files/", 0777, true);

        $fileModel = new File;
        $uploadDir = null;
        $maxSize = (5 * 1024 * 1024); // 5 mb 
        // file and filename 
        $file = $req->getUploadedFiles()['upload'];
        $file_name = $req->getParam('file_name');

        $oldName = $req->getParam('oldname');
        $oldFileUrl = $fileModel->getFileUrlByName($oldName); 
        $oldFile = $oldFileUrl; 
        unlink($oldFile);
        // unlink($oldFileThumb);

        $errors = [];

        /*************************************
         *            VALIDATIONS            *
         *************************************/
        if ($fileModel->fileNameExists($file_name, $id)) {
            $errors['unique'] = 'File name already exists elsewhere';
        }
        // get file size whence file is not null
        if (! empty($file)) {
            $fileSize = $file->getSize();   
            if ($maxSize - $fileSize < 0) {
                $errors['size'] = 'The file size is too large, uploads must be less than 5mb';
            }
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirect);
        }
        
        if (! $file->getError() == 4) { 

            $fileInfo = pathinfo($file->getClientFileName());
            $extension = $fileInfo['extension'];
            $pathinfo = pathinfo($file->getClientFileName());

            $fileType = $file->getClientMediaType();
            $type = (new MimeType)->findExtensions($fileType)[0];
            
            if (preg_match('/image\/*/', $type)) { 
                $uploadDir = $imageDir;
            } else {
                $uploadDir = $fileDir;
            }
            
            $filename = Helper::genRandom_uuid() . '.' . $extension;
            $size = Helper::human_fileSize($fileSize);
            $fileUrl = $uploadDir . $filename;

            $payload = [
                'size' => $size,
                'url' => $filename,
                'type' => $type,
            ];

            try {

                $file->moveTo($fileUrl);
                $done = true;

            } catch (Exception $e) { // if anything goes wrong --> throws error (RuntimeException precisely)
                
                $done = false;
            }
            
            if ($done) {
                $retv = $fileModel->updateFile($id, $payload);
            }
            
        } else {
            return $res->withRedirect($successRedirect);
        }

        if (! $retv) {
            $this->segment->setFlash('error', 'Something went wrong');
            return $res->withRedirect($failureRedirect);
        }
        $this->segment->setFlash('success', 'Update done!');
        return $res->withRedirect($successRedirect);
    }

    public function getCkFileManager($req, $res, $args) {
        $tmpl = 'admin/fileManager/ck_filemanager.twig';
        $query = $req->getUri()->getQuery();
        $queries = explode('&', $query);

        if (count($queries) > 3) {
            unset($queries[3]);
            $qs = implode('&', $queries);
        } else {
            $qs = $query;
        }
        
        $page = $req->getQueryParam('page', 1);
        $fileModel = new File;

        $error = $this->segment->getFlash('error');
        $images = $fileModel->getImagesForCk($page);

        $ctx = [
            'error' => $error,
            'images' => $images['data'],
            'pages' => $images['pageCount'],
            'current' => $page,
            'qs' => $qs,
        ];
        
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

    public function ckUploader($req, $res, $args) {
        $fileDir = file_exists("uploads/files/") ? "uploads/files/" : mkdir("uploads/files/", 0777, true);
        $fileModel = new File;        
        
        // file and filename 
        $file = $req->getUploadedFiles()['upload'];
        
        $payload = [];  

        $fileSize = $file ? $file->getSize() : 0;
        $fileInfo = pathinfo($file->getClientFileName());
        $extension = $fileInfo['extension'];

        $file_name = $file->getClientFilename('upload') . '_' . time() . '.' . $extension;
        $fileType = $file->getClientMediaType();
        $type = (new MimeType)->findExtensions($fileType)[0];

        $size = Helper::human_fileSize($fileSize);
        $fileUrl = $fileDir . $file_name;

        $payload = [
            'size' => $size,
            'url' => $file_name,
            'name' => $file_name,
            'type' => $type,
        ];

        try {
            $file->moveTo($fileUrl);
            $done = true;
        } catch (Exception $e) {
            $done = false;
        }
        if ($done) {
            $retv = $fileModel->createFile($payload);
        }

        $funcNum = $req->getQueryParam('CKEditorFuncNum');
        $CKEditor = $req->getQueryParam('CKEditor');
        $langCode = $req->getQueryParam('langCode');

        $message = 'The uploaded file has been renamed';
        $url = '/' . $fileUrl;

        echo "<script type='text/javascript'>
                window.parent.CKEDITOR.tools.callFunction($funcNum, '$url', '$message');
             </script>";
    }


}
