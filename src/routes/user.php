<?php 

$app->group('/admin', function() {
    
    $this->get(
        '/user',
         'Orbs\Controllers\UserController:getAllUsers'
    )->setName('getAllUsers');

    $this->get(
        '/user/create',
         'Orbs\Controllers\UserController:getCreateForm'
    )->setName('getCreateForm');

    $this->post(
        '/user/create',
         'Orbs\Controllers\UserController:postCreateForm'
    )->setName('postCreateForm');

    $this->get(
        '/user/edit/{id}',
         'Orbs\Controllers\UserController:getEditForm'
    )->setName('getEditForm');

    $this->post(
        '/user/edit/{id}',
         'Orbs\Controllers\UserController:postEditForm'
    )->setName('postEditForm');

     $this->post(
        '/user/delete/{id}',
         'Orbs\Controllers\UserController:deleteUser'
    )->setName('deleteUser');

    $this->post(
        '/user/is_active/{id}',
        'Orbs\Controllers\UserController:toggleUserActiveState'
    )->setName('toggleUserActiveState');
    
});
