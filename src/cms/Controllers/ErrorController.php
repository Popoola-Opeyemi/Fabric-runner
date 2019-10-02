<?php 

namespace Orbs\Controllers;

use Orbs\Models\Analytic;
/**
 * @package Orb Solutions
 */

class ErrorController extends Controller {

    public function error($req, $res, $args) {
        $template = 'error.twig';
        $ctx = [];

        $response = $this->view->render($res, $template, $ctx);
        return $response;
    }
}
