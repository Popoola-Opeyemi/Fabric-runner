<?php

use Orbs\Middleware\SiteGate;

$app->group('/', function() {

    $this->get(
        '[{path: .*}]',
        'Orbs\Controllers\FrontendController:index'
    )->setName('index');

    $this->post(
        'feedback',
        'Orbs\Controllers\FrontendController:postFeedbackForm'
    )->setName('postFeedbackForm');
    
})->add(new SiteGate());
