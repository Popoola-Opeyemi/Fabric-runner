<?php

namespace Orbs\Controllers;

use Orbs\Models\Widget;
use Orbs\Models\FileManager as File;
use PDOException;

/**
 * Widget Controller
 *
 * @package Orbs Solutions
 */
class WidgetController extends Controller {

    public function showWidgets($req, $res, $args) {
        $widgetModel = new Widget;
        $widgetTemplate = 'admin/widgets/all.twig';
        $widgets = $widgetModel->getWidgetsAndDetails();
        $widgetError = $this->segment->getFlash('error');

        $ctx = [
            'widgets' => $widgets,
            'error' => $widgetError,
        ];

        $response = $this->view->render($res, $widgetTemplate, $ctx);
        return $response;
      
    }


    public function getCreateWidget($req, $res, $args) {
      $widgetTemplate = 'admin/widgets/create.twig';
      $errors = $this->segment->getFlash('errors');
      $error = $this->segment->getFlash('error');
      $old = $this->segment->getFlash('old');
      $unassignedWidgets = (new Widget)->getUnassignedWidgets(); 
     
      
      $images = (new File)->getImages();
      $ctx = [
        'errors' => $errors,
        'error' => $error,
        'success' => $success,
        'images' => $images,
        'unassignedWidgets' => $unassignedWidgets,
        'old' => $old,
      ];
      $response = $this->view->render($res, $widgetTemplate, $ctx);
      return $response;
    }

    public function postCreateWidget($req, $res, $args) {

        $widgetModel = new Widget;
        $fileModel = new File;
        $requiredFields = ['name', 'heading', 'content',];
        $optionalFields = ['images',];
        $uniqueFields = ['name'];
        $data = $req->getParsedBody();
        $old = [];

        /***************************************
        * validation                          *
        **************************************/
        // validate required fields
        $errors = [];
        $failureRedirectRoute = '/admin/widgets/create';
        $successRedirectRoute = '/admin/widgets';

        foreach($requiredFields as $field) {
            $old[$field] = $data[$field];
        }
        $this->segment->setFlash('old', $old);
        foreach ($requiredFields as $required) {
            if (empty($data[$required]) || ! isset($data[$required])) {
                $errors[$required] = "{$required} field is required";
            }
        }
        $nameExists = $widgetModel->widgetNameExists($data['name']);
        if ($nameExists) {
            $errors['unique'] = 'Name already exists.';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        // validate or fillable fields
        $validFields = [];
        $validFields['name'] = $data['name'];
        $validFields['heading'] = $data['heading'];
        $validFields['content'] = $data['content'];
        $validFields['is_global'] = $data['is_global'];
        $validFields['attribute1'] = $data['attribute1'];
        $validFields['attribute2'] = $data['attribute2'];
        $validFields['attribute3'] = $data['attribute3'];
        $validFields['attribute4'] = $data['attribute4'];
        

        try {
            $this->db->beginTransaction();
            
            $lastInsertId = $widgetModel->createAWidget($validFields);

            if ($data['images']) {
                foreach($data['images'] as $imageId) {
                    $widgetModel->linkImageToWidget($imageId, $lastInsertId);
                }
            }
            if ( $data['children'] ) {
                foreach( $data['children'] as $child ) {
                    $widgetModel->setWidgetParent($lastInsertId, $child);
                }
            }
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
        $this->segment->setFlash('success', 'Widget Created successfully');
        return $res->withRedirect($successRedirectRoute);
       
    }
    
    public function postUpdateWidget($req, $res, $args) {

        $id = $args['id'];
        $widgetModel = new Widget;

        $requiredFields = ['name', 'heading','content',];
        $uniqueField = ['name'];
        $data = $req->getParsedBody();
        /***************************************
        * validation                          *
        **************************************/
        $errors = [];
        $failureRedirectRoute = "/admin/widgets/edit/$id";
        $successRedirectRoute = '/admin/widgets';

        $old = [];
        foreach($requiredFields as $field) {
                $old[$field] = $data[$field];
            }
        $this->segment->setFlash('old', $old);

        foreach ($requiredFields as $required) {
            if (empty($data[$required]) || !isset($data[$required])) {
                $errors[$required] = "{$required} field is required";
            }
        }
        $widgetNameExists = $widgetModel->widgetNameExistsElsewhere($id, $name);
        if ($widgetNameExists) {
            $errors['unique'] = 'This name already exists';
        }
        if ($widgetModel->widgetIsLinked($id)) {
            if ($data['is_global'] == "1") {
                $errors['widget_is_linked'] = 'Cannot set to global a linked widget, first unlink the widget then set to global';
            }
        }
        if (! empty($errors)) {
                $this->segment->setFlash('errors', $errors);
                return $res->withRedirect($failureRedirectRoute);
        }
       
        // validate or fillable fields
        $validFields = [];
        $validFields['name'] = $data['name'];
        $validFields['heading'] = $data['heading'];
        $validFields['content'] = $data['content'];
        $validFields['is_global'] = $data['is_global'];
        $validFields['attribute1'] = $data['attribute1'];
        $validFields['attribute2'] = $data['attribute2'];
        $validFields['attribute3'] = $data['attribute3'];
        $validFields['attribute4'] = $data['attribute4'];

        try {

            $this->db->beginTransaction();
            // update widget table 
            $retv = $widgetModel->updateWidget($id, $validFields); 
            // unlink all images in its list before update
            $widgetModel->unlinkWidgetImageLists($id);
            // detach all children from parent before update
            $widgetModel->unsetWidgetParent($id);
            // link back the images to Widget 
            if ($data['images']) {
                foreach($data['images'] as $image) {
                    $widgetModel->linkImageToWidget($image, $id);
                }
            }
            // reset parent to selected widgets to this
            if ($data['children']) {
                foreach($data['children'] as $child) {
                    $widgetModel->setWidgetParent($id, $child);
                }
            }
            $this->db->commit();
            $done = true;

        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong, please try again later");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'Widget updated successfully');
        return $res->withRedirect($successRedirectRoute);

    }


    public function getEditWidget($req, $res, $args) {
        $editTemplate = 'admin/widgets/edit.twig';
        $fileModel = new File;
        $widgetModel = new Widget;
        
        $id = $args['id'];
        $old = $this->segment->getFlash('old');
        $widget = $widgetModel->getWidgetById($id);
        $images = $fileModel->getImages();
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors');
        $widgetImages = $widgetModel->getArrayOfWidgetImagesById($id);
        $widgetChildren = $widgetModel->getWidgetChildren($id);
        $unAssignedWidgets = $widgetModel->getUnassignedWidgets();
        $ctx = [
            'error' => $error,
            'errors' => $errors,
            'widget' => $widget,
            'images' => $images,
            'widgetImages' => $widgetImages,
            'widgetChildren' => $widgetChildren,
            'unAssignedWidgets' => $unAssignedWidgets,
            'old' => $old,
        ];
        $response = $this->view->render($res, $editTemplate, $ctx);
        return $response;
    }


    public function deleteWidget($req, $res, $args) {
        $id = $args['id'];
        $widgetModel = new Widget;

        try {

            $this->db->beginTransaction();
            $widgetHasDependants = $widgetModel->widgetHasDependants($id);
            if ($widgetHasDependants) {
                return $res->withJson(
                    [
                        'has_dependants' => true,
                        'message' => 'Cannot delete a widget with dependants'
                    ]
                );
            }
            // if no dependants, then delete the link between widget images 
            // and the to-be deleted widget then delete 
            $widgetModel->unlinkWidgetImageLists($id);
            $widgetModel->deleteWidget($id);

            $this->db->commit();
            $done = true;
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
        
        if (! $done) {
            return $res->withJson(['error' => 'Something went wrong, try again later']);
        }
        return $res->withJson(
            [
                'is_deleted' => true,
            ]
        );
    }
    
}
