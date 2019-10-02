<?php 

namespace Orbs\Controllers;

use Slim\Container;
use Aura\Session\SessionFactory;
use Orbs\Core\Db;


/**
 * @package Orb Solutions
 */

class Controller {
    protected $view;
    protected $logger;
    protected $session;
    protected $segment;
    protected $db;
    protected $router;

    public function __construct(Container $container) {

        $this->view = $container->get('view');
        $this->logger = $container->get('logger');
        $this->router = $container->get('router');

        $session = (new SessionFactory)->newInstance($_COOKIE);
        $this->session = $session;
        $this->segment = $session->getSegment('orbs'); // orbs -> an arbitrary string to serve as key to the value stored
        $this->db = Db::getInstance();
    } 
} 


