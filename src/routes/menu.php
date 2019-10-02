<?php 

$app->group('/admin/menu', function() {

    $this->get(
        '',
        'Orbs\Controllers\MenuController:getMenuItems'
    )->setName('getMenuItems');

    $this->post(
        '/create',
        'Orbs\Controllers\MenuController:postCreateMenu'
    )->setName('postCreateMenu');

    $this->get(
        '/create',
        'Orbs\Controllers\MenuController:getCreateMenu'
    )->setName('getCreateMenu'); 


    $this->get(
        '/edit/{id}',
        'Orbs\Controllers\MenuController:getEditMenu'
    )->setName('getEditMenu');

    $this->post(
        '/edit/{id}',
        'Orbs\Controllers\MenuController:postUpdateMenu'
    )->setName('postUpdateMenu');

    $this->post(
        '/delete/{id}',
        'Orbs\Controllers\MenuController:deleteMenu'
    )->setName('deleteMenu');
    
});
