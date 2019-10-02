<?php

use Slim\Http\Cookies;

class Auth {
    
    /** 
     * Get the details of an authenticated `user` 
     */
    public static function getAuthUser() {
        $session = $_SESSION['orbs']['subscriber'];
        return $user;
        $user = isset($sesion['subscriber']) ? $session['subscriber'] : [];
    }

    /** 
     * Get details of cookie and set cookie 
     */
     public static function cookie() {
         $cookie = new Cookies($_COOKIE);
         return $cookie;
     }

     /**
      * Set cookie on the client 
      */
      public static function setCookie($name, $value) {
            setcookie($name, $value);
      }
      
      /** 
       * Get parsed cookie header 
       */ 
      public static function getParsedCookie($cookieHeader) {
          return Cookies::parseHeader($cookieHeader);
      }


}
