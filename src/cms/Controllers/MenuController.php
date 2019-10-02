<?php

namespace Orbs\Controllers;

use Orbs\Models\Menu;
use Orbs\Models\Page;

use Helper;

class MenuController extends Controller {

    public function getMenuItems($req, $res, $args) {
        $menuModel = new Menu;
        $pageLocation = 'admin/menu/all.twig';
        $success = $this->segment->getFlash('success');
        $error = $this->segment->getFlash('error');

        $internalMenu = $menuModel->getInternalMenu();
        $externalMenu = $menuModel->getExternalMenu();
        $menu = array_merge($internalMenu, $externalMenu);
        
        $ctx = [
            'menu_items' => $menu,
            'success' => $success,
            'error' => $error,
        ];

        $res = $this->view->render($res, $pageLocation, $ctx);
        return $res;
    }

    public function getCreateMenu($req, $res, $args) {
        $createMenuLocation = 'admin/menu/create.twig';
        $pages = (new Page)->getAllPages();
        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $ctx = [
            'pages' => $pages,
            'errors' => $errors,
            'error' => $error,
        ];
        $res = $this->view->render($res, $createMenuLocation, $ctx);
        return $res;
    }

    public function postCreateMenu($req, $res, $args) {
        $failureRedirectRoute = '/admin/menu/create';
        $successRedirectRoute = '/admin/menu';

        $data = $req->getParsedBody();
        $fillable = ['name', 'page_id', 'url', 'pos', 'is_visible',];
        $requiredFields = ['name', 'page_id']; 
        $valid = [];
        $errors = [];

        foreach ($requiredFields as $field) {
            if (($data[$field]) == null) {
                $errors[$field] = 'This field is required';
            }
        }
        
        if ($data['page_id'] < 1 && $data['url'] == "") {
            $errors['url'] = 'This field is needed for an external menu';
        }
 
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }

        // sanitize the valid field and send to menu model
        foreach ($fillable as $fill) {
            if (array_key_exists($fill, $data)) {
                $valid[$fill] = $data[$fill];
            }
        }
        if (empty($data['pos'])) {
            $valid['pos'] = 0;
        }
        if (empty($data['label'])) {
            $valid['label'] = Helper::toUrl($data['name']);
        }

        $done = (new Menu)->createMenuItem($valid);
        if (! $done) {
            $this->segment->setFlash('error', 'Something went wrong!');
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success','You have successfully created a menu item');
        return $res->withRedirect($successRedirectRoute);
    }

    public function getEditMenu($req, $res, $args) {
      $id = $args['id'];
      $editPageTemplate = 'admin/menu/edit.twig';
      $errors = $this->segment->getFlash('errors');
      $menu = (new Menu)->getMenuItemById($id);
      $ctx = [
          'errors' => $errors,
          'menu' => $menu,
      ];
      $response = $this->view->render($res, $editPageTemplate, $ctx);
      return $response;
    }


    public function postUpdateMenu($req, $res, $args) {
        $menuModel = new Menu;
        $fillable = ['name', 'url', 'pos', ];

        $id = $args['id'];
        $data = $req->getParsedBody();
        
        /*******************************
         *     VALIDATION             *
         ******************************/
       
        $validData = [];
        $errors = [];
        $successRedirectRoute = "/admin/menu";
        $failureRedirectRoute = "/admin/menu/edit/$id";

        if ($data['url'] == null) {
            if ($data['name'] == null) {
                $errors['name'] = 'This field is required';
            }
        }
        foreach($fillable as $fill) {
            if (array_key_exists($fill, $data)) {
                $validData[$fill] = $data[$fill];
            }
        }

        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        // time to update data update data
        $retv = $menuModel->updateMenuItem($id, $validData);
        
        if (! $retv) {
            $this->segment->setFlash('error', 'Something went wrong');
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', "Menu updated successfully");
        return $res->withRedirect($successRedirectRoute);

    }

    public function deleteMenu($req, $res, $args) {
        $id = $args['id'];
        $menuModel = new Menu;
        $menuIsExternal = $menuModel->isMenuExternal($id);
        if ($menuIsExternal) {
            return $res->withJson(
                [
                    'is_external' => true,
                    'message' => 'You cannot delete an external menu',
                ]
            );
        }
        $retv = $menuModel->deleteMenuItem($id);
        if ($retv) {
            return $res->withJson(
                [
                    'is_deleted' => true
                ]
            );
        } 
        return $res->withJson(
            [
                'error' => 'Something went wrong, please try again later',
            ]
        );
    }



}
