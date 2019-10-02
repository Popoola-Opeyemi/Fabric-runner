<?php

$app->group('/admin', function() {

    $this->get(
        '/inventory',
        'Orbs\Controllers\InventoryController:showInventory'
    )->setName('showInventory');

    $this->get(
        '/inventory/create',
        'Orbs\Controllers\InventoryController:getInventoryForm'
    )->setName('getInventoryForm');

    $this->post(
        '/inventory/create',
        'Orbs\Controllers\InventoryController:postInventoryForm'
    )->setName('postInventoryForm');

    $this->get(
      '/inventory/edit/{id}',
      'Orbs\Controllers\InventoryController:getEditInventoryForm'
    )->setName('getEditInventoryForm');

    $this->post(
        '/inventory/edit/{id}',
        'Orbs\Controllers\InventoryController:postEditInventoryForm'
    )->setName('postEditInventoryForm');  

    $this->post(
        '/inventory/delete/{name}',
        'Orbs\Controllers\InventoryController:deleteInventory'
    )->setName('deleteInventory');

});

