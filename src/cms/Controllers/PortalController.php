<?php 

namespace Orbs\Controllers;

use Auth; 
use Helper;
use Validator;
use Orbs\Models\Widget;
use Orbs\Models\Subscriber;


/**
 * @package Orb Solutions
 */
 class PortalController extends Controller {

     
     public function portalHome($req, $res, $next) {
         $tmpl = 'site/portal/home.twig';
         $news = (new Widget)->getWidgetByName('news');
         $cookie = Auth::cookie();
         $cookieName = 'remember';
         $cookieValues = [
             'value' => ''
         ];
        
         $ctx = [
            'link' => 'home',
            'account' => Auth::getAuthUser(),
            'news' => $news,
         ];
        
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }

     public function transactions($req, $res, $next) {
         $tmpl = 'site/portal/transactions.twig';
         $account = Auth::getAuthUser();
         $ctx = [
            'link' => 'transactions',
            'account' => $account,
         ];
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }

     // buy methods 
     public function buy($req, $res, $next) {
         $account = Auth::getAuthUser();
         $subscriberAccounts = (new Subscriber)->portalAccounts($account['id']);
         
         $tmpl = 'site/portal/buy.twig';
         $ctx = [
            'link' => 'buy',
            'account' => Auth::getAuthUser(),
            'payment_options' => $subscriberAccounts,
         ];
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }
     public function makePayment($req, $res, $ctx) {
        $tmpl = 'site/portal/confirmation.twig';
        $ctx = [
            'link' => 'buy',
            'account' => Auth::getAuthUser(),
            'content' => 'Payment successfully made'
        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
     }


    // sell methods 
     public function sell($req, $res, $args) {
         $tmpl = 'site/portal/sell.twig';
         $ctx = [
            'link' => 'sell',
            'account' => Auth::getAuthUser(),
         ];
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }
     
     /** 
      * sell currency
      */
     public function sellCurrency($req, $res, $args) {
        $account = Auth::getAuthUser();

        $tmpl = 'site/portal/confirmation.twig';
        $ctx = [
            'link' => 'sell',
            'account' => $account,
            'content' => 'Sales successfully made',
        ];
        $response = $this->view->render($res, $tmpl, $ctx);
        return $response;
     }

     // get profile
     public function profile($req, $res, $args) {
         $tmpl = 'site/portal/profile.twig';
         $account = Auth::getAuthUser();
         $subscriber = (new Subscriber)->getOne($account['id']);
         $dob = Helper::dateToStrings($subscriber['dob']); 
         $countries = (new Subscriber)->getCountries();
         $months = Helper::getMonths();
         $message = $this->segment->getFlash('message');

         $errors = $this->segment->getFlash('errors');
         $tab = $this->segment->getFlash('tab', 1); // tabs -> what tabs to show 
         $ctx = [
            'message' => $message,
            'tab' => $tab,
            'errors' => $errors,
            'link' => 'profile',
            'account' => $account,
            'subscriber' => $subscriber,
            'countries' => $countries,
            'dob' => $dob,
            'months' => $months,
         ];

         if ($tab == 1 && !$errors == null) { 
             $code = $subscriber['code'];
             $subscriber = $this->segment->getFlash('old');
             $subscriber['code'] = $code;
             $ctx['subscriber'] = $subscriber;
             $ctx['dob'] = Helper::dateToStrings($subscriber['dob']);
         } 

         return $this->view->render($res,$tmpl, $ctx);
     }

     /** 
      * update subscriber profile 
      */
     public function updateDetails($req, $res, $args) {
         $profileRoute = $this->router->pathFor('profile');
         $account = Auth::getAuthUser();
         $successRoute = $this->router->pathFor('profile');
         $year = $req->getParam('year');
         $month = $req->getParam('month');
         $day = $req->getParam('day');
         $dob = Helper::stringsToDate($year, $month, $day);
         $city = $req->getParam('city');
         $address = $req->getParam('address');
         $country = $req->getParam('country');
         $email = $req->getParam('email');
         $first_name = $req->getParam('first_name');
         $last_name = $req->getParam('last_name');
         $payload = [
             'dob' => $dob, 
             'country' => $country,
             'address' => $address, 
             'city' => $city, 
             'email' => $email,
             'first_name' => $first_name,
             'last_name' => $last_name,
         ];
         if ($dob == "") { unset($payload['dob']); }

         $requiredFields = ['first_name', 'last_name', 'email'];
         $errors = Validator::validate($requiredFields, $payload);
         if (Validator::mailCheck($this->db, 'subscriber', 'email', $payload['email'], $account['id'])) {
             $errors['email'] = 'Email already exists';
         }
         if (! empty($errors)) {
             $this->segment->setFlash('errors', $errors);
             $this->segment->setFlash('old', $payload);
             return $res->withRedirect($profileRoute);
         }
         $subscriberModel = new Subscriber;
         $subscriberModel->updateDetails($account['id'], $payload);
         return $res->withRedirect($profileRoute);
     }

     public function updatePassword($req, $res, $args) {
         $profileRoute = $this->router->pathFor('profile');
         $this->segment->setFlash('tab', 2);
         $account = Auth::getAuthUser();
         $password1 = trim($req->getParam('password1'));
         $password2 = trim($req->getParam('password2'));
         if ($password1 != $password2) {
             $errors['password'] = 'Both passwords must match';
         }
         if (! empty($errors)) {
             $this->segment->setFlash('errors', $errors);
             return $res->withRedirect($profileRoute);
         }
         $payload = [
             'password' => Helper::hashPassword($password1),
             'code' => $password1
         ];
         try {
            (new Subscriber)->updateDetails($account['id'], $payload);
            $done = true;
         } catch(Exception $e) {
            $error = $e->getMessage();
            $done = false;
         }  
         if (! $done) {
             $this->segment->setFlash('message', [
                 'class' => 'danger',
                 'content' => 'Something went wrong, please try again later'
             ]);
             return $res->withRedirect($profileRoute);
         }
         $this->segment->setFlash('message', [
                'class' => 'info',
                'content' => 'Password update was successful'
            ]);
         return $res->withRedirect($profileRoute);
     }
     

     // portal account 
     public function portalAccounts($req, $res, $args) {
         $tmpl = 'site/portal/accounts.twig';
         $ctx = [
            'link' => 'accounts',
            'account' => Auth::getAuthUser(),
         ];
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }

     public function addAccount($req, $res, $args) {
        $data = $req->getParsedBody();
        $requiredFields = ['account_type', 'account_name', 'account_number', 'bank_name', 'subscriber_id'];
        $errors = Validator::validate($requiredFields, $data);
        if (! empty($errors)) {
            return $res->withJson(["errors" => $errors], 400);
        }
        $result = (new Subscriber)->addAccount($data);
        return $res->withJson($result);
        if ($result) {
            return $res->withJson(['done' => true]);
        }
        return $res->withJson(['error' => 'Something went wrong'], 401);
     }
     
     /** 
      * just returns only an array of accounts created by the user 
      */
     public function subscriberAccounts($req, $res, $args) {
         $id = $args['id'];
         $accounts = (new Subscriber)->portalAccounts($id);
         return $res->withJson($accounts);
     }

     public function editFormPage($req, $res, $args) {
         $tmpl = 'site/portal/edit.accounts.twig';
         $id = $args['id'];
         $accountDetails  = (new Subscriber)->getSingleAccount($id);
        //  var_dump($accountDetails);return;
         $ctx = [
            'link' => 'accounts',
            'account' => Auth::getAuthUser(),
            'account_details' => $accountDetails,
            'account_types' => ['Savings Account', 'Current Account']
         ];
         $response = $this->view->render($res, $tmpl, $ctx);
         return $response;
     }

     public function deleteAccount($req, $res, $args) {
         $id = $args['id'];
         $result = (new Subscriber)->deleteAccount($id);
         if ($result) {
             return $res->withJson(['is_deleted' => true]);
         }
         return $res->withJson(['error' => 'Something went wrong, please try again later']);
     }
     
     /** 
      * Update a subscriber account 
      */
     public function updateAccount($req, $res, $args) {
         $redirectRoute = $this->router->pathFor('portalAccounts');
         $id = $args['id'];
         $account = Auth::getAuthUser();
     }

}
