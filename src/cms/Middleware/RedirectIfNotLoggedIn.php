<?php 

namespace Orbs\Middleware;

use Aura\Session;
use Orbs\Models\Setting;

class RedirectIfNotLoggedIn {

    public function __invoke($req, $res, $next) {
        $uri = $req->getUri();
        $path = $uri->getPath();

        $excludeRoutePatterns = ['@^/admin/login$@', '@^/admin/reset-password*@'];
        $adminPattern = '@^/admin*@';

        $loginRoute = '/admin/login';
        
        foreach ($excludeRoutePatterns as $exclude) {
            // next for the login route and reset password route
            if (preg_match($exclude, $path)) {
                return $next($req, $res);
            }
        }
       // if its an admin route
       // if its an admin route
       if (preg_match($adminPattern, $path)) { 
            $settingsModel = new Setting;
            $timeoutSettings = json_decode($settingsModel->getSettings('timeout')['setting'], true);
            $duration = $timeoutSettings['timeout'];
            // if user is not logged in
            $session = isset($_SESSION['orbs']) ? $_SESSION['orbs'] : null;
            if (! $session['user']['isLoggedIn']) {
                return $res->withRedirect($loginRoute);
            }
            // ensure session has not timed out before continuing  
            $timeout = time() + ((int)$duration * 60); // in minutes to be converted to seconds
            $timeoutDuration = isset($_SESSION['timeout']) ? $_SESSION['timeout'] : ($_SESSION['timeout'] = (time() + $timeout ));
            if ($timeoutDuration < time() ) {
                session_destroy(); // end session 
                return $res->withRedirect($loginRoute); // then redirect
            }
            $_SESSION['timeout'] =  $timeout; // reset time to start all over 
        }

        return $next($req, $res);
    }

}
