<?php 

namespace Orbs\Middleware;

/**
 * Redirect Trailing slash to a path without the trailing 
 * slash -- because slim route interprets "/this" as different
 * from "/this/"
 * 
 * @package Orb Solutions CMS
 */
class RedirectTrailingSlash {
    /**
     *
     * @param RequestInterface $req
     * @param ResponseInterface $res
     * @param MiddlewareAwareTrait $next
     * 
     * @return ResponseInterface
     * 
     */
    public function __invoke($req, $res, $next) {
        
         $uri = $req->getUri();
         $path = $uri->getPath();
    
         if ($this->hasTrailingSlash($path)) {
            $uri = $uri->withPath(substr($path, 0, -1));
            if ($req->isGet()) {
                return $res->withRedirect((string)$uri, 301);        
            } else {
                return $next($req->withUri($uri), $res);             
            }
         }
         return $next($req, $res);
    }

    private function hasTrailingSlash($path) {
        return ($path != '/' && substr($path, -1) == '/') ? true : false;
    }
    
}


