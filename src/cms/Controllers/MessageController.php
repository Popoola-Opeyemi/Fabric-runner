<?php 

namespace Orbs\Controllers;

use Orbs\Models\Message;
use Helper;

/**
 * @package Orb Solutions
 */

class MessageController extends Controller {

    public function getMessages($req, $res, $args) {
       $tmpl = "admin/message/all.twig";
       $messages = (new Message)->getAllMessages();
       $ctx = [
            'success' => $this->segment->getFlash('success'),
            'error' => $this->segment->getFlash('error'),
            'errors' => $this->segment->getFlash('errors'),
            'messages' => $messages
       ];
       $response = $this->view->render($res, $tmpl, $ctx);
    }

    public function updateMessage($req, $res, $args) {
        $route = $this->router->pathFor('getMessages');
        $type = $args['type'];
        $content = $req->getParam('content');
        $errors = $this->validateMessageByType($type, $content);
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($route);
        }
        $updated = (new Message)->updateMessage($type, $content);
        if (! $updated) {
            $this->segment->setFlash('error', 'Something went wrong, please try again');
            return $res->withRedirect($route);
        }
        $this->segment->setFlash('success', "$type content updated successfully");
        return $res->withRedirect($route);
    }


    /** validate message based on the  given type */
    private function validateMessageByType($type, $content, $required=['user']){
        switch($type) {
            case 'access-granted':
                return Helper::validateMsgTmpl($content, ['user', 'password']);
            default:
                return Helper::validateMsgTmpl($content, ['user']);
        }
    }

}
