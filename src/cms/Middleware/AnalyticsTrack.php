<?php 

namespace Orbs\Middleware;

use Orbs\Models\Analytic;
use Sinergi\BrowserDetector\Browser;
use Auth;
/**
 * Track all page visits and insert all request headers 
 * to the database.
 * 
 * @package Orbs Solutions CMS
 */

class AnalyticsTrack {
    
    /***************************************************** 
     *  The fields that are captured are: 
     *  ----------------------------------------
     *  | page_url | query | browser | member_id ... 
     *  ----------------------------------------
     *
     ****************************************************/
    private function getName($string) {
        if ($string == '/') {
            return 'home';
        }
        return substr($string, 1);
    }

    private function filterReferer($host, $referer) {
        if ($referer == null) {
            return "";
        }
        if (strpos($host, $referer) !== false) {
            return $referer;
        }
        return "";
    }

    private function getBrowser($userAgent) {
        $browser = new Browser($userAgent);
        return $browser->getName();
    }

    
    public function __invoke($req, $res, $next) {
        $adminPattern = '@^/admin*@';
        $uri = $req->getUri();
        $path = $uri->getPath();

        $excludePatterns = [
            '@^/site*@', '@^/css*@', '@^/js*@', '@^/favicon*@',
            '@^/uploads*@', '@^/robots*@', '@^/apple*@', 
            '@^/api*@', '@^/500*@',
        ];

        $response = $next($req, $res);
        
        // skip is request is of type POST
        if ( $req->isPost()) {
            return $response;
        }

        // skip if path is in the exclude list 
        foreach ($excludePatterns as $exclude) {
            if (preg_match($exclude, $path)) {
                return $response;
            }
        }

        // perform operation if route is not in exclude list 
        // is not a post request & 
        // is not an admin route 
        if (! preg_match($adminPattern, $path)) {
            $headers = $req->getHeaders();
            $host = $req->getUri()->getHost();
            $data = [];

            $refererString = isset($headers['HTTP_REFERER'][0]) ? $headers['HTTP_REFERER'][0] : null;

            $data['browser'] = $this->getBrowser($headers['HTTP_USER_AGENT'][0]);
            $data['page_url'] = $uri->getPath();
            $data['name'] = $this->getName($data['page_url']);
            $data['query'] = $uri->getQuery();
            $data['referer'] = $this->filterReferer( $host, $refererString );
            $session = isset($_SESSION['orbs']['subscriber']) ? $_SESSION['orbs']['subscriber'] : '';
            if ($session) {
                $data['session_id'] = $session['id'];
            }
            $analytics = new Analytic();
            $analytics->addNew($data);
        }

        return $response;
    }
    
}
