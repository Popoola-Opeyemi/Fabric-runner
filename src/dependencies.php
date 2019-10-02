<?php

// DIC configuration

use Orbs\Models\Setting;
use Monolog\Logger;
use Monolog\Handler\StreamHandler;
use Orbs\Core\Error;
use Orbs\Core\Config; 
use Orbs\Models\Subscriber;

$container = $app->getContainer();

// twig view template 
$container['view'] = function ($c) { 
    $mode = Config::getInstance()->get('mode');
    $visitors = isset($_SESSION['orbs']['subscriber']) ? $_SESSION['orbs']['subscriber'] : null;
    $pendingMembers = (new Subscriber)->getPendingMembers();
    $view = new Orbs\Core\Twig (__DIR__ . '/../templates', ['cache' => false]);
    $view->addExtension(new Orbs\Core\TwigExtension($c->router, $c->request->getUri()));
    $view->addGlobal('user', $_SESSION['orbs']['user']); 
    $view->addGlobal('visitor', $visitors);
    $view->addGlobal('mode', $mode);
    $view->addGlobal('pending_members', $pendingMembers);
    return $view;
};

// monolog
$container['logger'] = function($c) {
    $logger = new Monolog\Logger('Orb');
    $logger->pushHandler(
        new Monolog\Handler\StreamHandler(
            '/tmp/ledrop_err.html',
            Monolog\Logger::DEBUG
        )
    );
    $logger->pushHandler(new Monolog\Handler\FirePHPHandler());
    return $logger;
};


$container['phpErrorHandler'] = function($c) {
    return (new Error($c['logger']));
};

$container['errorHandler'] = function($c) {
    return (new Error($c['logger']));    
};
