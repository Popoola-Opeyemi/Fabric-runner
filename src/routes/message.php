<?php 

$app->group('/admin/message', function() {

    $this->get(
        '',
        'Orbs\Controllers\MessageController:getMessages'
    )->setName('getMessages');

    $this->post(
        '/edit/{type}',
        'Orbs\Controllers\MessageController:updateMessage'
    )->setName('updateMessage');

});
