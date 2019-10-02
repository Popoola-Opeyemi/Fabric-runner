<?php

$app->group('/admin', function() {

    $this->get(
        '/gallery',
        'Orbs\Controllers\GalleryController:getGalleryList'
    )->setName('getGallery');

    $this->get(
        '/gallery/create',
        'Orbs\Controllers\GalleryController:getCreateGallery'
    )->setName('getCreateGallery');
    $this->post(
        '/gallery/create',
        'Orbs\Controllers\GalleryController:postCreateGallery'
    )->setName('postCreateGallery');

    $this->get(
        '/gallery/photos/{name}',
        'Orbs\Controllers\GalleryController:getGalleryPhotos'
    )->setName('getGalleryPhotos');

    $this->get(
        '/api/gallery/categories',
        'Orbs\Controllers\GalleryController:getGalleryCategoriesApi'
    )->setName('getGalleryCategoriesApi');
    $this->post(
        '/api/gallery/categories',
        'Orbs\Controllers\GalleryController:postCreateCategoryApi'
    )->setName('postCreateCategoryApi');

    $this->post(
        '/api/gallery/editname',
        'Orbs\Controllers\GalleryController:editGalleryName'
    )->setName('editGalleryName');
    $this->post(
        '/gallery/delete/{name}',
        'Orbs\Controllers\GalleryController:deleteGallery'
    )->setName('deleteGallery');

});

