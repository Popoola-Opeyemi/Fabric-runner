<?php 

$app->group('/admin/members', function() {

    $this->get(
        '',
        'Orbs\Controllers\SubscriberController:getAllSubscribers'
    )->setName('getAllSubscribers');

    $this->get(
        '/create',
        'Orbs\Controllers\SubscriberController:getCreateSubscriberForm'
    )->setName('getCreateSubscriberForm');
    $this->post(
        '/create',
        'Orbs\Controllers\SubscriberController:postCreateSubscriberForm'
    )->setName('postCreateSubscriberForm');
    
    $this->get(
        '/files/{id}',
        'Orbs\Controllers\SubscriberController:getSubscriberFiles'
    )->setName('getSubscriberFiles');
    $this->get(
        '/edit/{id}',
        'Orbs\Controllers\SubscriberController:getEditSubscriberForm'
    )->setName('getEditSubscriberForm');
    $this->post(
        '/edit/{id}',
        'Orbs\Controllers\SubscriberController:postEditSubscriberForm'
    )->setName('postEditSubscriberForm');

    $this->post(
        '/delete/{id}',
        'Orbs\Controllers\SubscriberController:deleteSubscriber'
    )->setName('deleteSubscriber');
    $this->post(
        '/toggle/{id}',
        'Orbs\Controllers\SubscriberController:toggleSubscriberStatus'
    )->setName('toggleSubscriberStatus');
    $this->post(
        '/verify/{id}',
        'Orbs\Controllers\SubscriberController:verifySubscriber'
    )->setName('verifySubscriber');

});

