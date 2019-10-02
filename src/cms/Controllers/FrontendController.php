<?php

namespace Orbs\Controllers;

use Orbs\Models\Menu;
use Orbs\Models\Page;
use Orbs\Models\Post;
use Orbs\Models\Widget;
use Orbs\Models\Gallery;
use Orbs\Models\Setting;
use Orbs\Models\Message;
use Orbs\Core\Config;
use Mailgun\Mailgun;
use Orbs\Models\User;
use Orbs\Models\Subscriber;
use Helper;
use PDOException;
use Exception;
use Orbs\Models\Product;
use Validator;
use Mailer;
use Auth;

class FrontendController extends Controller {
    private function findWidgetParent($widgets, $w) {
         foreach ($widgets as $x=>$p) {
             if ($x == $w["widget_parent"]) {
                 return $p;
             }
         }
    }

    private function parseWidgets($widgets) {
        $retv = array();
        foreach($widgets as $w) {
            $w["children"] = array();
            $retv[$w["id"]] = $w;
        }

        foreach ($widgets as $w) {
            if ($w["widget_parent"] != 0) {
                $p = $this->findWidgetParent($retv, $w);
                
                array_push($p["children"], $w);

                $retv[$p["id"]] = $p;
            } 
        }

        $cleaned = array();
        foreach($retv as $w=>$v) {
            array_push($cleaned, $v);
        }

        return $cleaned;
    }

    private function render404($req, $res) {
        $tmpl = 'site/error404.twig';
        $ctx = $this->getDefaultCtx();
        $res = $res->withStatus(404);
        return $this->view->render($res, $tmpl, $ctx);
    }


    /**
     * default context includes items like - menu, page widget 
     * error & errors value, success data, and so on 
     */
    private function getDefaultCtx($widgetName = null) { 
        $brands = (new Product)->populatedBrands();
        $widgetModel = new Widget;
        $menuModel = new Menu; 
        $old = $this->segment->getFlash('old');
        $success = $this->segment->getFlash('success');
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors'); 
        $internalmenu = $menuModel->getInternalMenuWithUrl();
        $additionalMenu = $menuModel->getExternalMenu(); 
        $externalmenu = [];
        foreach($additionalMenu as $external) {
            $externalmenu[$external['name']] = $external;
        }
        if ($widgetName == null) {
            $widgets = $widgetModel->getIndexWidgets();
        } else {
            $widgets = $widgetModel->getWidgetsByUrl($widgetName);
        }
        $cleanedWidgets = [];
        $v = $this->parseWidgets($widgets);
        foreach($v as $w){
            $cleanedWidgets[$w['name']] = $w;
        }
        return [
            'internalmenu' => $internalmenu,
            'externalmenu' => $externalmenu,
            'widgets' => $cleanedWidgets, 
            'error' => $error, 
            'errors' => $errors, 
            'success' => $success, 
            'old' => $old,
            'brands' => $brands
        ];
    }

    public function index($req, $res, $args) {

        $menuModel = new Menu;
        $pageModel = new Page;
        $widgetModel = new Widget;
        $success = $this->segment->getFlash('success');
        $error = $this->segment->getFlash('error');
        $errors = $this->segment->getFlash('errors');
        $old = $this->segment->getFlash('old');
        $brands = (new Product)->populatedBrands();
        $internalmenu = $menuModel->getInternalMenuWithUrl();
        $externalmenu = [];
        $extMenu = $menuModel->getExternalMenu();
        foreach($extMenu as $ext) {
            $externalmenu[$ext['name']] = $ext;
        }
        $uri = $req->getUri();
        $urlStrings = explode('/', $uri->getPath());
        $url = $urlStrings[1];
        
        $indexPath = '/';
        $indexUrl = 'index'; 

        // for index view only 
        if (($url . '/') == $indexPath) {
            $page = $pageModel->getIndexPage(); // set index to fetch index page 
            $template = 'site/' . $page['file_name'] . '.twig';
            $widgets = $widgetModel->getIndexWidgets(); 
        } else { // for viewing other types
            $pageUrl = $url;
            $page = $pageModel->getPageByUrl($pageUrl);
            $template = 'site/' . $page['file_name'] . '.twig';  
            $widgets = $widgetModel->getWidgetsByUrl($pageUrl);
        } 
    
        $cleanedWidgets = [];
        $v = $this->parseWidgets($widgets);    
        foreach ($v as $w) {
            $cleanedWidgets[$w['name']] = $w;
        }
        // error page (404)
        if ($page == null) {
            return $this->render404($req, $res);
        }
       
        // if page is a blog
        if ($page['file_name'] == 'blog') {
            $months =  ['Jan', 'Feb', 'March', 'Apr', 'May', 'June', 'July', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
            $queries = $req->getQueryParams();
            $pageNumber = (isset($queries['page'])) ? (int)$queries['page'] : 1;
            $postModel = new Post;
            $limit = Config::getInstance()->get('pagination')['blog'];
            $rawPosts = $postModel->showPosts($pageNumber, $limit);
            $numRecords = $postModel->postCount();
            // To ensure that it doesn't go to a 404 page when no posts are created 
            // or published an even - as the route is still correct 
            if (! $numRecords == 0) {
                if (! $rawPosts) {
                    return $this->render404($req, $res);
                }
            }

            $posts = array_map(function($post) use ($months) {
                $post['month'] = $months[ (int)$post['month'] - 1 ];
                $post['day'] = strlen($post['day']) < 2 ? '0' . $post['day'] : $post['day'];
                $post['intro'] = substr(strip_tags($post['content']), 0, 200) . '...';
                return $post;
            }, $rawPosts);
            
            
            $categories = $postModel->getPostCategory();
            
            $ctx = [ 
                'pageNumber' => $pageNumber, 
                'records' => ceil( $numRecords / $limit ), 
                'posts' => $posts,
                'categories' => $categories,
                'internalmenu' => $internalmenu,
                'externalmenu' => $externalmenu,
                'brands' => $brands,
                'widgets' => $cleanedWidgets,
                'page' => $page,
                'link' => $url,
            ];
            return $this->view->render($res, $template, $ctx);
        }

        // for product view  
        if ($page['file_name'] == 'brands') {
            
            $tmpl = 'site/brands.twig';
            $uri = $req->getUri();
            $path = $uri->getPath();
            
            $category = isset($urlStrings[2]) ? $urlStrings[2] : '';
            $category = urldecode($category);
            $productModel = new Product;
            $categories = $productModel->populatedBrands();
            
            $products = $productModel->getProductCategoryItems($category);
            
            if (! $products) {
                return $this->render404($req, $res);
            }
            $ctx = [
                'internalmenu' => $internalmenu,
                'externalmenu' => $externalmenu,
                'brands' => $categories,
                'widgets' => $cleanedWidgets,
                'page' => $page,
                'link' => $url,
                'category' => $category,
                'products' => $products,
            ];
            // if path ends with /brands ? ...
            $productPathPattern = "/\/$urlStrings[1]$/";
            if (preg_match($productPathPattern, $path)) {
                $redirectTo = "$urlStrings[1]" . '/' . $categories[0]['name'];
                return $res->withRedirect($redirectTo);
            }
            $id = $req->getQueryParam('id');
            if (! is_null($id)) {
                $tmpl = 'site/drink.twig';
                $product = $productModel->getOneProduct($id);
                if (! $product) {
                    return $this->render404($req, $res);
                }
                $ctx = [
                    'internalmenu' => $internalmenu,
                    'externalmenu' => $externalmenu,
                    'brands' => $categories,
                    'widgets' => $cleanedWidgets,
                    'page' => $page,
                    'link' => $url,
                    'category' => $category,
                    'product' => $product,
                ];
                $response = $this->view->render($res, $tmpl, $ctx);
                return $response;
            }
            $response = $this->view->render($res, $tmpl, $ctx);
            return $response;
        } 
       
        $ctx = [
            'success' => $success,
            'error' => $error,
            'errors' => $errors,
            'old' => $old,
            "internalmenu" => $internalmenu,
            'externalmenu' => $externalmenu,
            'brands' => $brands,
            'message' => $this->segment->getFlash('message'),
            "widgets" => $cleanedWidgets,
            'page' => $page,
            'link' => $url,
        ];
        $response = $this->view->render($res, $template, $ctx);
        return $response;
    }

    public function onePost($req, $res, $args) {
        $brands = (new Product)->populatedBrands();
        $postModel = new Post;
        $widgetModel = new Widget;
        $menuModel = new Menu;
        $internalmenu = $menuModel->getInternalMenuWithUrl();
        $externalmenu = [];
        $extMenu = $menuModel->getExternalMenu();
        foreach($extMenu as $ext) {
            $externalmenu[$ext['name']] = $ext;
        }
        $tmpl = 'site/single_post.twig';
        $url = $args['url'];
        $post = $postModel->getPost($url);
        if (! $post) {
            return $this->render404($req, $res);
        }
        $widgets = $widgetModel->getWidgetsByUrl('blog');
        $cleanedWidgets = [];
        $v = $this->parseWidgets($widgets);    
        foreach ($v as $w) {
            $cleanedWidgets[$w['name']] = $w;
        }
        $categories = $postModel->getPostCategory();
        $comments = $postModel->getComments($post['id']);
       
        $ctx = [
            'comments' => $comments,
            'errors' => $this->segment->getFlash('errors'),
            'error' => $this->segment->getFlash('error'),
            'categories' => $categories,
            'post' => $post,
            'internalmenu' => $internalmenu,
            'externalmenu' => $externalmenu,
            'brands' => $brands,
            'widgets' => $cleanedWidgets
        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
    }

    public function error404($req, $res, $args) {
        $tmpl = 'site/error404.twig';
        $ctx = $this->getDefaultCtx();
        return $this->view->render($res, $tmpl, $ctx);
    }

    public function error500($req, $res, $args) {
        $tmpl = 'site/error500.twig';
        $ctx = $this->getDefaultCtx();
        return $this->view->render($res, $tmpl, $ctx);
    }

    public function addComment($req, $res, $args) {
        $path = $req->getUri()->getPath();
        $fields = ['comment', 'email', 'name', 'post_id'];
        $data = $req->getParsedBody();
        $postModel = new Post;
        $userModel = new User;
        $errors = [];
        $payload = [];
        foreach($fields as $field) {
            if ($data[$field] == null) {
                $errors[$field] = 'This field is required';
            }
        }
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($path);
        }
        try {
            $this->db->beginTransaction();
            $userData = [
                'email' => $data['email'],
                'name' => $data['name'],
            ];
            $payload['content'] = $data['comment'];
            $payload['user_id'] = $userModel->createTempUser($userData);
            $payload['post_id'] = $data['post_id'];
            $retv = $postModel->saveComment($payload);
            $this->db->commit();
            $done = true;
            
        } catch (PDOException $e) {
            $dbError = $e->getMessage();
            $this->logger->addInfo("A new comment failed $dbError");            
            $this->db->rollback();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong");
            return $res->withRedirect($path);
        }
        return $res->withRedirect($path);
    }

    // for frontend authentication 
    public function loginPage($req, $res, $args) {
        $ctx = $this->getDefaultCtx(); 
        $tmpl = 'site/login.twig';
        return $this->view->render($res, $tmpl, $ctx);
    }

    // 
    public function signUpPage($req, $res, $args) {
        $defaultCtx = $this->getDefaultCtx(); 
        $termsPage = (new Page)->getPageByName('Terms');
        $privacyPage = (new Page)->getPageByName('privacy');
        $newCtx = [
            'terms_page' => $termsPage,
            'privacy_page' => $privacyPage
        ];
        $ctx = array_merge($newCtx, $defaultCtx);
        $tmpl = 'site/sign_up.twig';
        return $this->view->render($res, $tmpl, $ctx);
    }

    // for frontend Login
    public function postSubscriberLogin($req, $res, $args) {

        $subscriberModel = new Subscriber;
        
        $failureRedirectRoute = $this->router->pathFor('loginPage');
        $previousPage = $_SESSION['referer'];
        $successRedirectRoute = $previousPage;
        if ($previousPage == null || $previousPage == '/login' || $previousPage == '/favicon.ico') {
            $successRedirectRoute = '/';
        }
        
        $email = trim($req->getParam('email'));
        $password  = trim($req->getParam('password'));
        $this->segment->setFlash('old', compact("email"));

        $errors = Validator::validate(['email', 'password'], $req->getParsedBody());
        if (! empty($errors)) {
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirectRoute);
        }
        $subscriberDetails = $subscriberModel->getLoginSubscriber($email);
        if ($subscriberDetails == null) {
            $this->segment->setFlash('error', 'Email or password combination is incorrect');
            return $res->withRedirect($failureRedirectRoute);
        }

        // check if user session is expired

        if ($subscriberDetails['status'] == 2 ) { 
            $this->segment->setFlash('error', 'You access has been revoked!');
            return $res->withRedirect($failureRedirectRoute);
        }

        $isPasswordValid = $subscriberModel->isPasswordValid($password, $subscriberDetails['password']);
        if (! $isPasswordValid) {
            $msg = "Your password is either incorrect or your session has expired.";
            $this->segment->setFlash('error', $msg);
            return $res->withRedirect($failureRedirectRoute);
        } 
        $session = [
            'isLoggedIn' => true,
            'id' => $subscriberDetails['id'],
            'email' => $subscriberDetails['email'],
            'first_name' => $subscriberDetails['first_name'],
            'last_name' => $subscriberDetails['last_name'],
        ];
        $this->segment->set('subscriber', $session); 
        $this->session->regenerateId();
        return $res->withRedirect($successRedirectRoute);
    }
    
    public function signUpSuccess($req, $res, $args) { 
        $name = $this->segment->getFlash('name');
        $rawMessage = (new Message)->getMessages('welcome')['content'];
        $clientMessage = str_replace("{{user}}", $name, $rawMessage);
        $message = [
            'message' => $clientMessage
        ];
        $ctx = array_merge($this->getDefaultCtx(), $message);
        $tmpl = "site/sign_up_success.twig";
        return $this->view->render($res, $tmpl, $ctx);
    }

    // for frontend SignUp
    public function postSubscriberSignUp($req, $res, $args) { 
        
        $settingsModel = new Setting;
        $verificationRoute = '/verification';
        $failureRedirect = $this->router->pathFor('signUpPage');
        $successRedirect = $this->router->pathFor('signUpSuccess');
        $subscriberModel = new Subscriber;
        
        $requiredFields = ['first_name', 'last_name', 'email', 'agreement']; 
        $data = $req->getParsedBody();
        $errors = Validator::validate($requiredFields, $data);
        if (! empty($errors)) { 
            $this->segment->setFlash('old', $data);
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($failureRedirect);
        }
        $payload = [];
        $payload['first_name'] = trim($data['first_name']);
        $payload['last_name'] = trim($data['last_name']);
        $payload['email'] = trim($data['email']);
        $payload['password'] = Helper::genHash(7);

        $mailTmpl = 'mails/alert.twig';
        $emailSettings = json_decode((new Setting)->getSettings('email')['setting'], true);
        $adminEmail = $emailSettings['sender_email'];
       
        $name = $payload['first_name'] . ' ' . $payload['last_name'];
        $clientMessage = (new Message)->getMessages('welcome')['content'];
        $clientMessage = str_replace("{{user}}", $name, $clientMessage);
        $adminMessage = (new Message)->getMessages('admin-alert')['content'];
        $adminMessage = str_replace("{{user}}", $name, $adminMessage);

        try {
            $this->db->beginTransaction();
            $created = $subscriberModel->createSubscriber($payload);
            Mailer::sendMail(
                'smtp', 
                $payload['email'], 
                ['content' => $clientMessage, 'subject' => 'Request for Access'],
                $this->view,
                $mailTmpl
            );
            Mailer::sendMail(
                'smtp', 
                $adminEmail, 
                [ 'content' => $adminMessage, 'subject' => 'Request for Access'],
                $this->view,
                $mailTmpl
            );
            $this->db->commit();
            $done = true; 
        } catch (Exception $e) {
            $err = $e->getMessage();
            $this->db->rollback();
            $done = false;
        }
        if ($done) {
            $this->segment->setFlash('name', $name);
            return $res->withRedirect($successRedirect);
        } else {
            $this->segment->setFlash('error', "Something went wrong, please try again later.");
            return $res->withRedirect($failureRedirect);
        } 
    }

    // verify subscriber 
    public function verifySubscriber($req, $res, $args) {
        $token = $args['token'];
        $loginPage = $this->router->pathFor('loginPage');
        $subscriberModel = new Subscriber;
        $valid = $subscriberModel->isTokenValid($token);
        if (! $valid) {
            $this->segment->setFlash('error', 'Token has been used or is not longer valid');
            return $res->withRedirect($loginPage);
        }
        $verified = $subscriberModel->verifySubscriber($token);
        if (! $verified) {
            $this->segment->setFlash('error', 'Something went wrong, please try again');
            return $res->withRedirect($loginPage);
        }
        $this->segment->setFlash('success', 'Your account has been verified, you can now login');
        return $res->withRedirect($loginPage);
    }

    public function logoutSubscriber($req, $res, $args) {
        //
    }

    public function postFeedbackForm($req, $res, $args) {

        $redirectRoute = '/';
        $data = $req->getParsedBody();       
        $fields = ['name', 'email', 'content', 'phone'];
        $errors = Validator::validate($fields, $data); 
        if (! empty($errors)) {
            $this->segment->setFlash('old', $data);
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($redirectRoute);
        }
        
        $notification = "Thank you for getting in touch! We will reply by as soon as possible. Have a great day!";
       
        $content = "A new enquiry has been sent by " . $data['name'] . " with the following details: <br>" 
            . "Email: " . $data['email'] . "<br>"
            . "Phone: " . $data['phone'] . "<br>" 
            . "Date sent: " . date('Y-m-d H:i:s'). "<br>"
            . "<p style='text-decoration:underline'>Content:</p><br>" . $data['content'] . "<br>";
        $tmpl = 'mails/contact.twig';
        $emailSettings = json_decode((new Setting)->getSettings('email')['setting'], true);
        $adminEmail = $emailSettings['sender_email'];
        try {
            Mailer::sendMail('smtp', $adminEmail, ['user' => 'Admin', 'subject' => 'New Enquiry', 'content' => $content ], $this->view, $tmpl);
            $done = true;
        } catch (Exception $e) {
            $err = $e->getMessage(); 
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', $notification);
            return $res->withRedirect($redirectRoute);
        }
        
        $this->segment->setFlash('success', $notification);
        return $res->withRedirect($redirectRoute);
    }

    /** Get the password recovery form */
    public function resetSubscriberPasswordForm($req, $res, $args) {
        $tmpl = 'site/password_reset.twig';
        $ctx = $this->getDefaultCtx();
        return $this->view->render($res, $tmpl, $ctx);
    }

    public function postSubscriberPasswordReset($req, $res, $args) {
        $failureRedirectRoute = $this->router->pathFor('resetSubscriberPasswordForm');
        $loginRoute = $this->router->pathFor('loginPage');
        $subscriberModel = new Subscriber;
        $email = $req->getParam('email'); 

        if ($email == null) {
            $this->segment->setFlash('error', 'Please provide an email address.');
            return $res->withRedirect($failureRedirectRoute);
        }
        if (! $subscriberModel->emailExists($email)) {
            $this->segment->setFlash('old', [ 'email' => $email ]);
            $this->segment->setFlash('error', 'This email is not recognized.');
            return $res->withRedirect($failureRedirectRoute);
        }
        $payload = [];
        $subscriber = $subscriberModel->getByEmail($email);
        $payload['subscriber_id'] = $subscriber['id'];
        $payload['token'] = bin2hex(random_bytes(32));
        
        $origin = $req->getHeader('HTTP_ORIGIN')[0];
        $subject = 'Ledrop: Password reset';

        $path =  $this->router->pathFor('newPasswordResetForm', ['token' => $payload['token'] ]);
        $resetLink = $origin . $path;
        $messageBody = 'Please click ' . '<a href="'. $resetLink 
            . '">here</a><br> to reset your password or copy the link below into your browser.' 
            . '<br><br>' . $resetLink . '<br><br>' 
            . ' If you haven\'t requested this password reset request, please contact us immediately!';
        $mailTmpl = 'mails/password_reset.twig';
        $user = $subscriber['first_name'] . ' ' . $subscriber['last_name'];
        try {
            $this->db->beginTransaction();
            Mailer::sendMail(
                'http',
                $email, 
                [
                    'subject' => $subject,
                    'content' => $messageBody,
                    'user' => $user
                ],
                $this->view,
                $mailTmpl
            );
            $dataExists = $subscriberModel->subscriberRecoveryDataExists($subscriber['id']);
            if ($dataExists) { // delete the data
                $subscriberModel->deleteRecoveryData($subscriber['id']);
            }
            $subscriberModel->addRecoveryData($payload);
            $this->db->commit();
            $done = true;
        } catch(Exception $e) {
            $this->db->rollback();
            $err = $e->getMessage();
            $done = false;
        }
        if (! $done) {
            $this->segment->setFlash('error', "Something went wrong, please try again later.");
            return $res->withRedirect($failureRedirectRoute);
        }
        $this->segment->setFlash('success', "A mail has been sent to you, follow the link to reset your password.");
        return $res->withRedirect($loginRoute);
    }

    public function newPasswordResetForm($req, $res, $args) {
        $tmpl = 'site/new_password.twig';
        $token = $args['token'];
        $subscriberModel = new Subscriber;
        $recoveryData = $subscriberModel->getRecoveryData($token);
        if (! $recoveryData) {
            $loginPage = $this->router->pathFor('loginPage');
            $this->segment->setFlash('error', 'This link has expired, please send a new request.');
            return $res->withRedirect($loginPage);
        }
        $ctx = array_merge($this->getDefaultCtx(), ['token' => $token]); 
        return $this->view->render($res, $tmpl, $ctx);
    }

    public function passwordResetUpdate($req, $res, $args) {
        $token = $args['token'];
        $errors = [];
        $redirectRoute = $this->router->pathFor('passwordResetUpdate', ['token' => $token]);
        $loginRoute = $this->router->pathFor('loginPage');
        $subscriberModel = new Subscriber;;
        $password1 = $req->getParam('password1');
        $password2 = $req->getParam('password2');
        if ($password1 != $password2) {
            $errors['no_match'] = 'Both passwords do not match';
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($redirectRoute);
        }
        $recoveryData = $subscriberModel->getRecoveryData($token);
        if (! $recoveryData ) {
            $errors['expired_token'] = 'This link has expired';
            $subscriberModel->deleteRecoveryData($recoveryData['subscriber_id']);
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($redirectRoute);
        }
        if ( $token != $recoveryData['token'] ) {
            $errors['invalid_token'] = 'The link is invalid';
            $subscriberModel->deleteRecoveryData($recoveryData['subscriber_id']);
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($redirectRoute);
        }
        $updated = $subscriberModel->updatePassword($recoveryData['subscriber_id'], $password1);
        if (! $updated) {
            $errors['unknown'] = 'Something is not right!';
            $this->segment->setFlash('errors', $errors);
            return $res->withRedirect($redirectRoute);
        }
        $this->segment->setFlash('success', 'Password updated successfully, you can now login.');
        $subscriberModel->deleteRecoveryData($token);
        return $res->withRedirect($loginRoute);
        
    } 

}

