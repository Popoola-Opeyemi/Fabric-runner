<?php 

namespace Orbs\Middleware;

/** 
 * Add $_SESSIONS global array to all requests 
 *
 * @package Orb solutions CMS
 */
 
 class AddSessionsToRequests {
     
     public function __invoke($req, $res, $next) {
         if (! isset($_SESSION['orbs'])) {
             $_SESSION['orbs'] = null;
         }
         if (! isset($_SESSION['orbs']['user'])) {
             $_SESSION['orbs']['user'] = null;
         }
         $request = $req->withAttribute('session', $_SESSION['orbs']['user']);
         $response = $next($request, $res);
         return $response;
     }
 }
