<?php 

namespace Orbs\Controllers;

use Orbs\Models\Post;
use Orbs\Models\FileManager as File;
use PDOException;
use Helper;
use Validator;

class PostController extends Controller {

    /*
     * Get all posts 
     */
    public function Posts($req, $res, $args) {
        $tmpl = 'admin/blog/all.twig';
        $postModel = new Post;
        $posts = $postModel->getAllPosts();
      
        $ctx = [
            'posts' => $posts,
            'error' => $this->segment->getFlash('error'),
            'success' => $this->segment->getFlash('success'),
            'errors' => $this->segment->getFlash('errors'), 
        ];
        return $this->RenderPost($res, $tmpl, $ctx); 
    }

    public function CreatePostForm($req, $res, $args) {
        $tmpl = 'admin/blog/create.twig';
        $postModel = new Post;
        $categories =$postModel->Categories();
        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');
        $ctx = [
            'categories' => $categories,
            'errors' => $errors,
            'error' => $error, 
            'old' => $old,
        ];
        return $this->RenderPost($res, $tmpl, $ctx);
        
    }

    private function RenderPost($res, $tmpl, $ctx) {
        return $this->view->render($res, $tmpl, $ctx);
    }

    /** 
     * Get a single post for views & edits
     */
    public function Post($req, $res, $args) {
        $tmpl = 'admin/blog/edit.twig';
        $postModel = new Post;
        $id = $args['id'];
        $post= $postModel->getPostById($id);
        $categories =$postModel->Categories();
        
        $ctx = [
            'post' => $post,
            'categories' => $categories,
            'error' => $this->segment->getFlash('error'),
            'errors' => $this->segment->getFlash('errors'),
            'old' => $this->segment->getFlash('old'), 
        ];

        return $this->view->render($res, $tmpl, $ctx); 
    }

    /** 
    * Shows the form to create a new post
    */
    public function EditPostForm($req, $res, $args) {
        $tmpl = 'admin/blog/edit.twig';
        $postModel = new Post;
        $categories =$postModel->Categories();
        $errors = $this->segment->getFlash('errors');
        $old = $this->segment->getFlash('old');
        $error = $this->segment->getFlash('error');
        
        $ctx = [
            'categories' => $categories,
            'errors' => $errors,
            'error' => $error,
            'old' => $old 
        ];
        return $this->view->render($res, $tmpl, $ctx);
    }

    /** 
     * Create the actual post and persist the data 
     */
    public function SavePost($req, $res, $args) {
       
        $requiredFields = [
            'title', 'content', 'published_date', 
        ];
        $optionalFields = [
            'url', 'seo_keywords','seo_description', 'is_published', 'thumbnail'
        ];
        
        $uniqueFields = ['title']; // so you remember to validate against it

        $data = $req->getParsedBody();
        $thumbnail = $req->getUploadedFiles()['thumbnail'];
        $postModel = new Post;
        $fileModel = new File;
        $payload = [];
        $errors = [];
        
        $successRedirectRoute = $this->router->pathFor('Posts');
        $failureRedirectRoute = $this->router->pathFor('CreatePostForm');
        // populate the session values with old inputs 
        $this->segment->setFlash('old', $data);

        // validating required fields
        $fieldErrors = Validator::validate($requiredFields, $data);
        $fileErrors = Validator::validateFile($thumbnail);
        $errors = array_merge($fieldErrors, $fileErrors);
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        if ($postModel->titleExists($data['title'])) {
            $errors['title'] = 'Title already exists';
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);            
        }

        // sanitize fields and send only the right fields 
        foreach ($requiredFields as $field) {
            $payload[$field] = $data[$field];
        }
        foreach ($optionalFields as $field) {
            $payload[$field] = $data[$field];
        }

        // validating url field
        if ($data['url'] == null) {
            $payload['url'] = Helper::toUrl($data['title']);
        } else {
            $payload['url'] = Helper::toUrl($data['url']);
        }
        // file meta data for to upload 
        $fileMeta = Helper::uploadFile($thumbnail, $payload['url']);
        // author id field 
        $session = $req->getAttribute('session');
        $id = $session['user_id'];
        $payload['author_id'] = $id;

        try {
            $this->db->beginTransaction();
            $image_id = $fileModel->createFile($fileMeta);
            $payload['thumbnail'] = $image_id; 
            $postModel->savePost($payload);
            $done = true;
            $this->db->commit();
        } catch (PDOException $e) {
            $this->db->rollback();
            $error = $e->getMessage();
            $done = false;
        } catch (Exception $e) {
            $this->db->rollback();
            $error = $e->getMessage();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong $error");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'News created successfully');
        return $res->withRedirect($successRedirectRoute);
    }

    public function UpdatePost($req, $res, $args) {
        $tmpl = '/admin/blog/edit.twig';
        $id = $args['id'];
        $requiredFields = ['title', 'content', 'published_date' ];
        $optionalFields = ['url', 'seo_keywords','seo_description', 'is_published',];
        $uniqueFields = ['title']; 
        $data = $req->getParsedBody();
        $thumbnail = $req->getUploadedFiles()['thumbnail'];

        $postModel = new Post;
        $fileModel = new File;
        $payload = []; 
        $errors = [];
        $successRedirectRoute = $this->router->pathFor('Posts');
        $failureRedirectRoute = $this->router->pathFor('GetPost', ['id' => $id]); 
        
        
        // validating required fields
        $errors = Validator::validate($requiredFields, $data);

        $noFile = $thumbnail->getError() == 4;
        
        // if there is a thumbnail 
        if (! $noFile) {
            $errors = array_merge($errors, Validator::validateFile($thumbnail));
        }
        
        if ($data['title'] && $postModel->titleExists($data['title'], $id)) {
            $errors['title'] = 'Title already exists';        
        }
       
        if (! empty($errors)) {
            $categories = $postModel->Categories();
            $post = $data;           
            $ctx = [
                'errors' => $errors,
                'post' => $post,
                'categories' => $categories,
            ];
            return $this->RenderPost($res, $tmpl, $ctx);
        }
        
        foreach ($requiredFields as $field) {
            $payload[$field] = $data[$field];
        }
        foreach ($optionalFields as $field) {
            $payload[$field] = $data[$field];
        }
        if ($data['url'] == null) {
            $payload['url'] = Helper::toUrl($data['title']);
        } else {
            $payload['url'] = Helper::toUrl($data['url']);
        }
        try {
            $this->db->beginTransaction();
            if (! $noFile) {
                $fileMeta = Helper::uploadFile($thumbnail, $payload['url']);
                $image_id = $fileModel->createFile($fileMeta); 
                $payload['thumbnail'] = $image_id;
            }
            $postModel->updatePost($id, $payload);
            $this->db->commit();
            $done = true;
        } catch (PDOException $e) {
            $this->db->rollback();
            $error = $e->getMessage();
            $done = false;
        }
        
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($failureRedirectRoute);
        }

        $this->segment->setFlash('success', 'Post updated successfully.');
        return $res->withRedirect($successRedirectRoute);
    }

    /**
     * Delete a post by id 
     */
    public function DeletePost($req, $res, $args) {
        $id = $args['id'];
        $postModel = new Post;
        $deleted = $postModel->deletePost($id);
        if (! $deleted) {
            return $res->withJson(['error' => 'Something went wrong']);
        } 
        return $res->withJson(['is_deleted' => true]);
      }

     /* 
      * publish or un-publish a post
      */
     public function PublishPost($req, $res, $args) {
        $id = $args['id'];
        $postModel = new Post;
        $result = $postModel->togglePublished($id);
        return $res->withJson($result);
      }


     /*
      * add category 
      */
     public function AddCategory($req, $res, $args) {
        $name = $req->getParam('name');
        $postModel = new Post;
        $result = $postModel->addCategory($name);
        return $res->withJson($result);
    }

    public function EditCategory($req, $res, $args) {
          $id = $args['id'];
          $catName = $req->getParam('name');
          $this->logger->addInfo($catName);
          $result = (new Post)->updateCategoryName($id, $catName);
          $this->logger->addInfo($result);
          return $res->withJson(['done' => $result]);
    }

    public function commentsPerPost($req, $res, $args) {
        $postId = $args['post_id'];
        $postModel = new Post;
        $this->logger->addInfo("got a request");
        $comments = $postModel->getCommentsPerPost($postId);
        return $res->withJson($comments);
    }

    public function togglePostComment($req, $res, $args) {
        $postModel = new Post;
        $comment_id = $args['comment_id'];
        $result = $postModel->togglePostComment($comment_id);
        return $res->withJson($result);
    }

    public function deleteComment($req, $res, $args) {
        $comment_id = $args['comment_id'];
        $postModel = new Post;
        $result = $postModel->deleteComment($comment_id);
        if (! $result ) {
            return $res->withJson(['is_deleted' => false]);
        }
        return $res->withJson(['is_deleted' => true]);
    }

     
    
}
