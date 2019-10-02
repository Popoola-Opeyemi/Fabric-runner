<?php

namespace Orbs\Controllers;

use Orbs\Models\Page;
use Orbs\Models\Widget;
use Orbs\Models\Template;
use Helper;
use Exception;

/**
 * @package Orb Solutions
 */

class PageController  extends Controller {

    /**
     * list all pages ordered by id
     */
    public function listPages($req, $res, $args) {
        // $this->logger->addInfo('testing logger', ['something' => 'went wrong']);
        $allPagesRoute = 'admin/pages/all.twig';

        // get page number from query param --- ( ?page=* )
        $pageNum = $req->getQueryParam('page', 1);
        $pages = (new Page())->getAll($pageNum);
        $error = $this->segment->getFlash('error');

        $ctx = [
            'pages' => $pages,
            'error' => $error,
        ];
        $response = $this->view->render($res, $allPagesRoute, $ctx);
        return $response;
    }

    public function getCreatePage($req, $res, $args) {
        $createPageRoute = 'admin/pages/create.twig';
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors');
        $templates = (new Template)->getAllTemplates(); 
        $widgets = (new Widget)->getAllWidgets();

        $old = $this->segment->getFlash('old');
        
        $ctx = [
            'errors' => $errors,
            'widgets' => $widgets,
            'error' => $error,
            'old' => $old,
            'templates' => $templates,
        ];
        return $this->view->render($res, $createPageRoute, $ctx);
    }


    public function postCreatePage($req, $res, $args) {

        $requiredFields = [
            'name', 'content', 'title', 'template',
        ];
        
        $optionalFields = [
            'url', 'template', 'seo_keywords', 'seo_description', 
            'is_published','type', 'protected'
            // add to the list as app grows
        ];
        $uniqueFields = ['name'];

        // received data
        $data = $req->getParsedBody();
        // page model instance
        $pageModel = new Page();
        /**************************************************
        * VALIDATIONS                                     *
        **************************************************/
        $validData = [];
        $errors = [];

        $successRedirectRoute = '/admin/page';
        $failureRedirectRoute = '/admin/page/create';

        // populate the session values with old inputs 
        $this->segment->setFlash('old', $data);

        // validating required fields
        foreach($requiredFields as $field) {
            if (empty($data[$field]) || !isset($data[$field])) {
                $errors[$field]  = "This is a required field";
            }
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        // validating unique fields
        foreach($uniqueFields as $fill) {
            if ($pageModel->pageFieldExists($fill, $data[$fill])) {
                $errors[$fill]  = "{$fill} already exists";
            }
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        // sanitize fields and send only the right fields 
        $validFields = array_merge($requiredFields, $optionalFields);
        foreach($validFields as $fill) {
            if (array_key_exists($fill, $data)) {
                $validData[$fill] = $data[$fill];
            }
        }
        // validating url field
        if (empty($data['url'])) {
            $validData['url'] = Helper::toUrl($data['title']);
        }
        

        try {

            $this->db->beginTransaction();
            if ($data['type'] == 1) {
                $pageModel->deactivateIndex();
                $lastInsertId = $pageModel->createPage($validData, 1);
            } else {
                $lastInsertId = $pageModel->createPage($validData);
            }
        
            $pageModel->removePageWidgetById($lastInsertId);
            if ($data['widgets']) {
                $retv = $pageModel->linkPageWidgetsToId($lastInsertId, $data['widgets']);
            }

            $done = true;

            $this->db->commit();
            
        } catch (Exception $e) {
            $dbError = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }

        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($failureRedirectRoute);
        }

        $this->segment->setFlash('success', 'Great! Page created');
        return $res->withRedirect($successRedirectRoute);
    }


    public function getEditPage($req, $res, $args) {
        $editPageTemplate = 'admin/pages/edit.twig';

        $id = $args['id'];
        $page = (new Page)->getOnePage($id);  // update model to include template file_name
        $widgets = (new Widget)->getAllWidgets();
        $pageWidgets = (new Widget)->getAllWidgetsById($id);
        $templates = (new Template)->getAllTemplates();
        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        
        $ctx = [
          'page' => $page,
          'widgets' => $widgets,
          'pageWidgets' => $pageWidgets,
          'templates' => $templates,
          'error' => $error,
          'errors' => $errors,
        ];
        
        $response = $this->view->render($res, $editPageTemplate, $ctx);
        return $response;
    }

    public function deletePage($req, $res, $args) {
        $pageModel = new Page;
        $id = $args['id'];
        // check if page is_index and page and prevent delete 
        $isIndex = $pageModel->isIndexPage($id);
        if ($isIndex) {
            return $res->withJson(
                [
                    'is_index' => true,
                    'message' => 'An index page cannot be deleted',
                ]
            );
        }
        $retv = $pageModel->deletePage($id);
        
        if ($retv) {
            return $res->withJson(['is_deleted' => true]);
        }
        return $res->withJson(['error' => 'Something went wrong']);
    }

    public function postUpdatePage($req, $res, $args) {
        // the columns to be filled 
        $fillable = [
            'title', 'content', 'url', 'type', 'seo_description', 'seo_keywords', 
            'template', 'is_published', 'protected'
        ];
        
        $uniqueFields = ['title', 'url'];

        // The is_index field 
        $indexField = ['is_index'];
        // save errors 
        $errors = [];

        $id = $args['id'];
        $pageModel = new Page;

        $failureRedirectRoute = "/admin/page/edit/$id";
        $successRedirectRoute = "/admin/page";
        // The data 
        $data = $req->getParsedBody();
       
        $validFields = [];
        foreach ($fillable as $valid) {
          if (array_key_exists($valid, $data)) {
            $validFields[$valid] = $data[$valid];
          }
        }
        // Homepage cannot be protected!
        if ($data['template'] == '1') {
            $validFields['protected'] = 0;
        }

        foreach($uniqueFields as $unique) {
            if ($pageModel->pageFieldExistsElsewhere($id, $unique, $data[$unique])) {
                $errors[$unique] = "{$unique} already exists elsewhere";
            }
        }
        
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
    
        // transaction begins 
        try {

            $this->db->beginTransaction();
            if ($data['type'] == 1) {
                $pageModel->deactivateIndex();
                $pageModel->updatePage($id, $validFields, 1);
            } else {
                $pageModel->updatePage($id, $validFields);
            }

            // some widget logic
            $pageModel->removePageWidgetById($id);
            if ($data['widgets']) {
                $pageModel->linkPageWidgetsToId($id, $data['widgets']);
            }
            // at this point all went well, so commit all updates
            $this->db->commit();
            $done = true;
        
        } catch (Exception $e) {
            $this->db->rollBack();
            $dbError = $e->getMessage();
            $done = false;
        } 
        // transaction ends
        if (! $done) {
            $this->segment->setFlash('error', "something went wrong!");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'Page updated successfully');
        return $res->withRedirect($successRedirectRoute);
    }


    /** 
     * toggle published page status
     */
    public function publishPage($req, $res, $args) {
        $id = $args['id'];
        $pageModel = new Page;
        $result = $pageModel->togglePublished($id);
        return $res->withJson($result);
    }

    public function searchPage($req, $res, $args) {
        $term = $req->getParam('q');
        preg_match();
        if (empty($term) && preg_match('/\s*/', $term)) {
            return $res->withRedirect('/admin/page');
        }
        $redirectRoute = "/admin/page/search/$term";
        return $res->withRedirect($redirectRoute);
    }

    public function getSearchPage($req, $res, $args) {
        $term = $args['term'];
        $pageModel = new Page;
        $template = 'admin/pages/search.twig';
        $result = $pageModel->searchPage($term);
        $ctx = [
            'results' => $results,
        ];
        $response = $this->view->render($res, $template, $ctx);
        return $response;
    } 
    
}
