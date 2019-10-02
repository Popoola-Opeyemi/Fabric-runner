<?php 

namespace Orbs\Controllers;

use Orbs\Models\FileManager as File;
use Orbs\Models\Product;
use PDOException;
use Exception;
use Helper;
use Validator;

/** 
 * Brands controller 
 */
class BrandsController extends Controller {
    
    /** get all products */
    public function getAllProducts($req, $res, $args) {

        $tmpl = 'admin/products/all.twig';
        $productModel = new Product;
        $products = $productModel->getAllProducts();
        $ctx = [
            'products' => $products,
            'error' => $this->segment->getFlash('error'),
            'errors' => $this->segment->getFlash('errors'), 
        ];
        return $this->view->render($res, $tmpl, $ctx); 
    }

    /** render a page to add product */
    public function addProductPage($req, $res, $args) {
        
        $tmpl = 'admin/products/create.twig';
        $productModel = new Product;
        $categories = $productModel->productCategories();
        $ctx = [
            'categories' => $categories,
            'error' => $this->segment->getFlash('error'),
            'errors' => $this->segment->getFlash('errors'), 
        ];
        return $this->view->render($res, $tmpl, $ctx); 
    }


    public function addProductCategory($req, $res, $args) {
        $category = $req->getParam('name');
        $productModel = new Product;
        $result = $productModel->addProductCategory($category);
        return $res->withJson($result , 200);
    }

    /** get a single product */
    public function getProduct($req, $res, $args) {
        $tmpl = 'admin/products/edit.twig';
        $productModel = new Product;
        $id = $args['id'];
        $categories = $productModel->productCategories();
        $product = $productModel->getOneProduct($id);
        $ctx = [
            'categories' => $categories,
            'product' => $product,
            'error' => $this->segment->getFlash('error'),
            'errors' => $this->segment->getFlash('errors')
        ];
        return $this->view->render($res, $tmpl, $ctx); 
    }

    public function createProductCategory($req, $res, $args) {
        $category = $req->getParam('name');
        $productModel = new Product;
        if ($category == null) {
            return $res->withJson(['message' => 'category name is empty'], 401);
        }
        if ($productModel->categoryExists($category)) {
            return $res->withJson(['message' => 'category name already exists'], 401);
        }
        $result = $galleryModel->addCategory($category);
        return $res->withJson($result , 200);
    }

    /** save a product */
    public function saveProduct($req, $res, $args) {
        $fileModel = new File;
        $productModel = new Product;
        $requiredFields = ['name', 'category', 'description'];
        $failureRedirect = $this->router->pathFor('addProductPage');
        $successRedirect = $this->router->pathFor('getAllProducts');
        $file = $req->getUploadedFiles()['image'];
        $data = $req->getParsedBody();
        
        $fileLabel = $data['image_label'] ? Helper::toUrl($data[image_label]) : Helper::toUrl($data['model']);
        
        // $category = $data['category'];
        // validate request body and file 
        $errors = array_merge(Validator::validate($fields, $data), Validator::validateFile($file));
        if ($fileModel->fileNameExists($file_name)) {
            $errors['unique'] = 'This file name already exists';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirect);
        }
        $imageMeta = Helper::uploadFile($file, $fileLabel);
        if (! $imageMeta) {
            $this->segment->setFlash('error', "Something went wrong, please try again later");
            return $res->withRedirect($failureRedirect);
        }
        try {
            $this->db->beginTransaction();
            $imageID = $fileModel->createFile($imageMeta); 
            $productMeta = [
                'product_category_id' => $data['category'],
                'file_id' => $imageID,
                'name' => $data['name'],
                'model' => $data['model'],
                'description' => $data['description'], 
                'specification' => $data['specification'] 
            ];
            $productModel->save($productMeta);
            $this->db->commit();
            $done = true;
        } catch (Exception $e) {
            $err = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "An error occurred, please try again later");
            return $res->withRedirect($successRedirect);
        }

        $this->segment->setFlash('success', 'Product added successfully');
        return $res->withRedirect($successRedirect);
    }

    /** update a product details*/
    public function editProduct($req, $res, $args) {
        $id = $args['id'];
        $fileModel = new File;
        $productModel = new Product;
        $fields = ['name', 'category', 'description'];
        $failureRedirect = $this->router->pathFor('editProduct', ['id' => $id]);
        $successRedirect = $this->router->pathFor('getAllProducts');
        
        $file = $req->getUploadedFiles()['image'];
        $data = $req->getParsedBody();

        $fileLabel = $data['image_label'] ? Helper::toUrl($data[image_label]) : Helper::toUrl($data['model']);
        
        $category = $data['category'];
        $errors = Validator::validate($fields, $data);
        // if no file is selected for upload - update content only 
        if ($file->getError() ==  UPLOAD_ERR_NO_FILE) { 
            if (! empty($errors)) {
                $this->segment->setFlash('errors', $errors);
                return $res->withRedirect($failureRedirect);
            }
            $productMeta = [
                'product_category_id' => $data['category'],
                'file_id' => $data['image_id'],
                'name' => $data['name'],
                'model' => $data['model'],
                'description' => $data['description'],
                'specification' => $data['specification'] 
            ]; 
            $done = $productModel->update($id, $productMeta);
            if (! $done) {
                $this->segment->setFlash('error', 'An error occurred, please try again later');
                return $res->withRedirect($failureRedirect);
            }
            $this->segment->setFlash('success', 'Product updated successfully');
            return $res->withRedirect($successRedirect);
        }
        
        $errors = array_merge($errors, Validator::validateFile($file));
        if ($fileModel->fileNameExists($file_name, $data['image_id'])) {
            $errors['unique'] = 'This file name already exists';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirect);
        }
        $fileName = $fileModel->getFileById($data['image_id']);
        $imageMeta = Helper::uploadFile($file, $fileLabel);
        
        if (! $imageMeta) {
            $this->segment->setFlash('error', 'Something went wrong');
            return $res->withRedirect($failureRedirect);
        }
        try {
            $this->db->beginTransaction();
            $imageID = $fileModel->createFile($imageMeta); 
            $productMeta = [
                'product_category_id' => $data['category'],
                'file_id' => $imageID,
                'name' => $data['name'],
                'model' => $data['model'],
                'description' => $data['description']
            ];
            $productModel->update($id, $productMeta);
            $this->db->commit();
            $done = true;
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "An error occurred, perhaps -> $dbError");
            return $res->withRedirect($failureRedirect);
        }
        // delete file only after new file is successfully uploaded 
        Helper::deleteFile($fileName['url']);
        $this->segment->setFlash('success', 'Gallery item added successfully');
        return $res->withRedirect($successRedirect);
    }
    
    /** edit a product category */
    public function editProductCategory($req, $res, $args) {
        $id = $args['id'];
        $newName = trim($req->getParam('name'));
        $productModel = new Product; 
        $done = $productModel->updateCategory($id, $newName);
        if (! $done) {
            return $res->withJson(['error' => 'Something is not right']);
        }
        return $res->withJson(['is_updated' => true]);
    }

    /** delete a product */
    public function deleteProduct($req, $res, $args) {
        $id = $args['id'];
        $productModel = new Product;
        $done = $productModel->deleteProduct($id);
        if (! $done) {
            return $res->withJson(['error' => 'Something is not right']);
        }
        return $res->withJson(['is_deleted' => true]);
    }
}

