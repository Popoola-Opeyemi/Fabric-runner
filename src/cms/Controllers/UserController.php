<?php 

namespace Orbs\Controllers;

use PDOException;
use Orbs\Models\User;

class UserController extends Controller {

    public function getAllUsers($req, $res, $args) {
        $tmpl = 'admin/user/all.twig';
        $userModel = new User;
        $error = $this->segment->getFlash('error');
        $success = $this->segment->getFlash('success');
        
        $users = $userModel->getAll(); 
        $user = $req->getAttribute('session');
        
        $ctx = [
            'user' => $user,
            'error' => $error,
            'success' => $success,
            'users' => $users,
        ];

        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

     public function getCreateForm($req, $res, $args) {
        $tmpl = 'admin/user/create.twig';
        $userModel = new User;
        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');
        $success = $this->segment->getFlash('success');
        
        
        $roles = $userModel->getUserRoles();

        $ctx = [
            'old' => $old,
            'roles' => $roles,
            'errors' => $errors,
            'error' => $error,
            'success' => $success,

        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }


    public function postCreateForm($req, $res, $args) {
        $failureRedirectRoute = '/admin/user/create';
        $successRedirectRoute = '/admin/user';
        $userModel = new User;

        $data = $req->getParsedBody();
        $requiredFields = [
            'firstname', 'lastname', 'username', 
            'email', 'password', 'role',
        ];
        
        $errors = [];
        $this->segment->setFlash('old', $data);

        foreach ($requiredFields as $field) {
            if ( ($data[$field]) == null ) {
                $errors[$field] = 'This field is required';
            }
        }
        if ($userModel->userNameExists($data['username'])) {
            $errors['usernameExists'] = 'This username already exists';
        }
        if ($userModel->emailExists($data['email'])) {
            $errors['emailExists'] = 'This email already exists';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        $validFields = [];
        $validFields['username'] = $data['username'];
        $validFields['firstname'] = $data['firstname'];
        $validFields['lastname'] = $data['lastname'];
        $validFields['email'] = $data['email'];
        $validFields['password'] = $userModel->hashPassword($data['password']);
        $validFields['role_id'] = $data['role'];

       
        try {
            $this->db->beginTransaction();
            $lastInsertId = $userModel->createUser($validFields);
            $done = true;
            $this->db->commit();
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $done = false;
            $this->db->rollback();
        }

        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'User added successfully');
        return $res->withRedirect($successRedirectRoute);
    }

    public function getEditForm($req, $res, $args) {
        $session = $req->getAttribute('session');
        $id = $args['id'];
        $userModel = new User;
        if (($userModel->userRole($id))['id'] == 1) {
            $this->segment->setFlash('error', 'Cannot edit a super user account');
            return $res->withRedirect('/admin/user');
        }
        
        $tmpl = 'admin/user/edit.twig';
        $userModel = new User;

        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');
        $success = $this->segment->getFlash('success');

        $user = $userModel->getUser($id);
        $roles = $userModel->getUserRoles();
        
        $ctx = [
            'old' => $old,
            'roles' => $roles,
            'errors' => $errors,
            'error' => $error,
            'success' => $success,
            'user' => $user,
        ];
        return $this->renderEditForm($res, $tmpl, $ctx);
    }

    private function renderEditForm($res, $tmpl, $ctx) {
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;        
    }


    public function postEditForm($req, $res, $args) {
        $id = $args['id'];
        $failureRedirectRoute = "/admin/user/edit/$id";
        $tmpl = '/admin/user/edit.twig';
        $successRedirectRoute = '/admin/user';
        $userModel = new User;

        $data = $req->getParsedBody();
        
        $requiredFields = [
            'firstname', 'lastname', 'username', 
            'email', 'role_id',
        ];
        $optionalFields = ['password',];
        
        $error = [];
        $this->segment->setFlash('old', $data);
        
        foreach ($requiredFields as $field) {
            if (($data[$field]) == null) {
                $errors[$field] = 'This field is required';
            }
        }
        if ($data['username'] && $userModel->userNameExists($data['username'], $id)) {
            $errors['usernameExists'] = 'This username already exists';
        }
        if ($data['email'] && $userModel->emailExists($data['email'], $id)) {
            $errors['emailExists'] = 'This email already exists';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            $roles = $userModel->getUserRoles();
            $errors = $this->segment->getFlashNext('errors');
            $old = $this->segment->getFlashNext('old');
            $old['id'] = $id;
            $ctx = [
                'errors' => $errors,
                'user' => $old,
                'roles' => $roles,
            ];
            return $this->renderEditForm($res, $tmpl, $ctx);
        }
        $validFields = [];
        $validFields['username'] = $data['username'];
        $validFields['firstname'] = $data['firstname'];
        $validFields['lastname'] = $data['lastname'];
        $validFields['email'] = $data['email'];
        $validFields['role_id'] = $data['role_id'];
        if ($data['password'] != null) {
            $validFields['password'] = $userModel->hashPassword($data['password']);
        }
        try {

            $this->db->beginTransaction();
            $userModel->update($id, $validFields);
            $done = true;
            $this->db->commit();

        } catch (PDOException $e) {
            
            $dbError = $e->getMessage();
            $done = false;
            $this->db->rollback();
        }

        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($failureRedirectRoute);
        }

        $this->segment->setFlash('success', 'User details updated');
        return $res->withRedirect($successRedirectRoute);
    }

    public function deleteUser($req, $res, $args) {
        $session = $req->getAttribute('session');
        $id = $args['id'];
        $userModel = new User;
        if ( ($userModel->userRole($id))['id'] == 1) { // 1 is a superuser
            return $res->withJson(['message' => 'Cannot delete a super user account']);
        }
        $deleted = $userModel->delete($id);
        if (! $deleted) {
            return $res->withJson(['message' => 'Something went wrong, please try again later',]);
        }
        return $res->withJson(['is_deleted' => true,]);
    }

    public function toggleUserActiveState($req, $res, $args) {
        $userModel = new User;
        $session = $req->getAttribute('session');
        $id = $args['id'];

        $role = $userModel->userRole($id);

        if ($role['id'] == 1) { // 1 is for a super user
            return $res->withJson(['is_super' => true ]);
        }
        $result = $userModel->toggleUserActiveState($id);
        return $res->withJson($result);
    }


}
