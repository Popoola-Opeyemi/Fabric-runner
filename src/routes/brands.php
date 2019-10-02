<?php 

$app->group('/admin/products', function() {
    
    $this->get(
        '', 
        'Orbs\Controllers\BrandsController:getAllProducts'
    )->setName('getAllProducts');

    $this->post(
        '/category',
        'Orbs\Controllers\BrandsController:addProductCategory'
    )->setName('addProductCategory');
    $this->get(
        '/add',
        'Orbs\Controllers\BrandsController:addProductPage'
    )->setName('addProductPage');

    $this->get(
        '/edit/{id}', 
        'Orbs\Controllers\BrandsController:getProduct'
    )->setName('getProduct');
    
    $this->post(
        '/edit/{id}',
        'Orbs\Controllers\BrandsController:editProduct'
    )->setName('editProduct');

    $this->post(
        '/save',
        'Orbs\Controllers\BrandsController:saveProduct'
    )->setName('saveProduct');

    $this->post(
        '/delete/{id}',
        'Orbs\Controllers\BrandsController:deleteProduct'
    )->setName('deleteProduct');

    $this->post(
        '/category/edit/{id}', 
        'Orbs\Controllers\BrandsController:editProductCategory'
    )->setName('editProductCategory');

});
