<?php 

namespace Orbs\Controllers;



use Orbs\Models\FileManager as File;
use Orbs\Models\Gallery;
use Helper;
use PDOException;
use Orbs\Models\Setting;
use Validator;


class SettingsController extends Controller {

    public function getAllSettings($req, $res, $args) {
        $tmpl = 'admin/settings/all.twig';
        $settingsModel = new Setting;
        $email = json_decode($settingsModel->getSettings('email')['setting'], true);
        $timeout = json_decode($settingsModel->getSettings('timeout')['setting'], true);
        $smtp = json_decode($settingsModel->getSettings('smtp')['setting'], true);
        $ctx = [
            'errors' => $this->segment->getFlash('errors'),
            'error' => $this->segment->getFlash('error'),
            'success' => $this->segment->getFlash('success'),
            'email' => $email,
            'timeout' => $timeout,
            'smtp' => $smtp,
        ];
        $res = $this->view->render($res, $tmpl, $ctx);
        return $res;
    }

    public function updateTimeoutSettings($req, $res, $args) {
        $data = $req->getParsedBody();
        $redirectRoute = $this->router->pathFor('getAllSettings');
        $fields = ['timeout'];
        $errors = Validator::validate($fields, $data);
        if (! empty($errors)) {
            $this->segment->setFlash('errors', 'Timeout field cannot be left empty');
            return $res->withRedirect($redirectRoute);
        }
        $details = json_encode([
            'timeout' => $data['timeout']
        ]); 
        (new Setting)->updateSettings('timeout', $details);
        $this->segment->setFlash('success', 'Timeout parameters successfully updated');
        return $res->withRedirect($redirectRoute);
    }

    public function updateSMTPSettings($req, $res, $args) {
        $data = $req->getParsedBody();
        $redirectRoute = $this->router->pathFor('getAllSettings');
        $fields = ['host', 'port', 'username', 'password'];
        $errors = Validator::validate($fields, $data);
        if (! empty($errors)) {
            $this->segment->setFlash('errors', "All fields required");
            return $res->withRedirect($redirectRoute);
        }
        $details = json_encode([
            'host' => $data['host'],
            'port' => $data['port'],
            'username' => $data['username'],
            'password' => $data['password']
        ]); 
        (new Setting)->updateSettings('smtp', $details);
        $this->segment->setFlash('success', 'SMTP parameters successfully updated');
        return $res->withRedirect($redirectRoute);
    }

    public function updateEmailSettings($req, $res, $args) {
        $data = $req->getParsedBody();
        $redirectRoute = $this->router->pathFor('getAllSettings');
        $fields = ['sender_email', 'sender_name'];
        $errors = Validator::validate($fields, $data);
        if (! empty($errors)) {
            $this->segment->setFlash('errors', 'All fields are required');
            return $res->withRedirect($redirectRoute);
        } 
        $details = json_encode([
            'sender_email' => $data['sender_email'],
            'sender_name' => $data['sender_name']
        ]);
        (new Setting)->updateSettings('email', $details);
        $this->segment->setFlash('success', 'Email parameters successfully updated');
        return $res->withRedirect($redirectRoute);
    }

  
}

