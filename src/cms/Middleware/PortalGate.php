<?php 

namespace Orbs\Middleware;

use Aura\Session;
// use Orbs\Models\Settings;

class PortalGate {

    public function __invoke($req, $res, $next) {
        
        $uri = $req->getUri();
        $path = $uri->getPath();

        $excludeRoutePatterns = [];
        $portalPattern = '@^/portal*@';

        $authRoute = '/authenticate';
        // check if some routes to be excluded exist
        if (count($excludeRoutePatterns) > 0) {
            // if there are white listed routes
            foreach($excludeRoutePatterns as $exclude) {
                if (preg_match($exclude, $path)) {
                    return $next($req, $res);
                }
            }
        }

        if (preg_match($portalPattern, $path)) {
            // if user is not logged in
            $session = isset($_SESSION['orbs']) ? $_SESSION['orbs'] : null;
            if (! isset($session['subscriber']) ){
                return $res->withRedirect($authRoute);
            }
        }

        return $next($req, $res);

    }

}
