<?php 

namespace Orbs\Controllers;

use Orbs\Models\Subscriber;
use Orbs\Models\Message;
use Helper;
use Mailer;
use Auth;
use PDOException;
use Exception;

class SubscriberController  extends Controller {
    
    /** 
     * It returns a list of subscribers to view 
     */
    public function getAllSubscribers($req, $res, $args) {
        $tmpl = 'admin/subscribers/all.twig';
        $subscriberModel = new Subscriber;
        $error = $this->segment->getFlash('error');
        $success = $this->segment->getFlash('success');

        $subscribers = $subscriberModel->getAll();
       
        $ctx = [
            'subscribers' => $subscribers,
            'error' => $error,
            'success' => $success,
        ];
        return $this->view->render($res, $tmpl, $ctx);
    }

    /** 
     * It toggles status of a subscriber, switching between active -> true | false  
     */
    public function toggleSubscriberStatus($req, $res, $args) {
        $subscriberModel = new Subscriber;
        $id = $args['id'];
        $status = $req->getQueryParam('status');
        $result = $subscriberModel->updateSubscriberStatus($id, $status);
        $name = $result['first_name'] . ' ' . $result['last_name'];
        $password = $result['password'];
        $recipientEmail = $result['email'];
        $tmpl = "mails/alert.twig";
        $granted = $result['status'] == 1 ? true : false;
        $messageType = $granted ? 'access-granted' :'access-revoked';
        $subject = $granted ? 'Access Granted' : 'Access Revoked';
        $message = (new Message)->getMessages($messageType)['content'];
        $message = str_replace("{{user}}", $name, $message);
        $message = str_replace("{{password}}", $password, $message);
        try {
            Mailer::sendMail('smtp', $recipientEmail, ['subject' => $subject, 'content' => $message], $this->view, $tmpl);
            return $res->withJson($result);
        } catch(Exception $e) {
            return $res->withJson(['error' => 'An error occurred']);
        }
    }

    /** 
     * It renders form to edit a subscriber 
     */
    public function getEditSubscriberForm($req, $res, $args) {
        $id = $args['id'];
        $subscriberModel = new Subscriber;
        
        $tmpl = 'admin/subscribers/edit.twig';

        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');
        $success = $this->segment->getFlash('success');

        $subscriber = $subscriberModel->getOne($id);
        
        $ctx = [
            'old' => $old,
            'roles' => $roles,
            'errors' => $errors,
            'error' => $error,
            'success' => $success,
            'subscriber' => $subscriber,
        ];
        return $this->view->render($res, $tmpl, $ctx);
    }

    /** 
     * It renders form to create a subscriber 
     */
    public function getCreateSubscriberForm($req, $res, $args) {
        
        $tmpl = 'admin/subscribers/create.twig';

        $errors = $this->segment->getFlash('errors');
        $error = $this->segment->getFlash('error');
        $old = $this->segment->getFlash('old');
        $success = $this->segment->getFlash('success');
        
        $ctx = [
            'old' => $old,
            'errors' => $errors,
            'error' => $error,
            'success' => $success,
            'user' => $user,
        ];
        return $this->view->render($res, $tmpl, $ctx);
    }

    public function postCreateSubscriberForm($req, $res, $args) {
        $failureRedirectRoute = $this->router->pathFor('getCreateSubscriberForm');
        $successRedirectRoute = $this->router->pathFor('getAllSubscribers');
        $subscriberModel = new Subscriber;
        $data = $req->getParsedBody();
        $requiredFields = [
            'first_name', 'last_name', 'email', 'password'
        ];
        $errors = [];
        $this->segment->setFlash('old', $data);
        foreach ($requiredFields as $field) {
            if ( ($data[$field]) == null ) {
                $errors[$field] = 'This field is required';
            }
        }
        if ($subscriberModel->emailExists($data['email'])) {
            $errors['emailExists'] = 'This email already exists on our system!';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        $validFields = [];
        $validFields['first_name'] = trim($data['first_name']);
        $validFields['last_name'] = trim($data['last_name']);
        $validFields['email'] = trim($data['email']);
        $validFields['status'] = 1; 
        $validFields['password'] = $data['password'];
        
        try {
            $this->db->beginTransaction();
            $subscriberModel->createSubscriber($validFields);
            $done = true;
            $this->db->commit();
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $done = false;
            $this->db->rollback();
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong, please try again later");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'Subscriber added successfully');
        return $res->withRedirect($successRedirectRoute);
    }

    public function postEditSubscriberForm($req, $res, $args) {
        $id = $args['id'];
        $failureRedirectRoute = $this->router->pathFor('getEditSubscriberForm', ['id' => $id]);
        $successRedirectRoute = $this->router->pathFor('getAllSubscribers');
        $subscriberModel = new Subscriber;
        $data = $req->getParsedBody();
        $requiredFields = ['first_name', 'last_name', 'email'];
        $errors = [];
        $this->segment->setFlash('old', $data);
        foreach ($requiredFields as $field) {
            if ( ($data[$field]) == null ) {
                $errors[$field] = 'This field is required';
            }
        }
        if ($subscriberModel->emailExists($data['email'], $id)) {
            $errors['emailExists'] = 'This email already exists';
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        $validFields = [];
        $validFields['first_name'] = $data['first_name'];
        $validFields['last_name'] = $data['last_name'];
        $validFields['email'] = $data['email'];
        if ($data['password'] != null) {
            $validFields['password'] = Helper::hashPassword($data['password']);
        }
        try {
            $this->db->beginTransaction();
            $subscriberModel->updateSubscriber($validFields, $id);
            $done = true;
            $this->db->commit();
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $done = false;
            $this->db->rollback();
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong, please try again later");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', 'Subscriber Updated successfully');
        return $res->withRedirect($successRedirectRoute);
    }

    public function deleteSubscriber($req, $res, $args) {
        $id = $args['id'];
        $subscriberModel = new Subscriber;
        $deleted = $subscriberModel->delete($id);
        if (! $deleted) {
            return $res->withJson(['message' => 'Something went wrong, please try again later']);
        }
        return $res->withJson(['is_deleted' => true]);
    }

   
    public function logoutSubscriber($req, $res, $args) {
        $redirectPath = $this->router->pathFor('loginPage');
        $this->session->destroy();
        // destroy session by setting it to negative expiry time or -1
        Auth::setCookie('rememberPT', '', -1);
        return $res->withRedirect($redirectPath);
    }
    
}

