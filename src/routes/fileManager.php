<?php 

// :: file manager routes 
$app->group('/admin/files', function () {

    // GET route for login 
    $this->get(
        '', 
        'Orbs\Controllers\FileManagerController:getFileManager'
    )->setName('getFileManager');

    
    $this->get(
        '/create',
        'Orbs\Controllers\FileManagerController:getUploadFile'
   )->setName('getUploadFile'); 

   $this->post(
       '/create',
       'Orbs\Controllers\FileManagerController:postUploadFile'
   )->setName('postUploadFile');


   $this->get(
       '/edit/{id}',
       'Orbs\Controllers\FileManagerController:getUpdateFile'
   )->setName('getUpdateFile');
   $this->post(
       '/edit/{id}',
       'Orbs\Controllers\FileManagerController:postUpdateFile'
   )->setName('postUpdateFile');


   $this->post(
       '/delete/{id}',
       'Orbs\Controllers\FileManagerController:deleteFile'
   )->setName('deleteFile');

});

// ckeditor routes 
$app->get(
    '/admin/filemanager',
    'Orbs\Controllers\FileManagerController:getCkFilemanager'
)->setName('getCkFilemanager');

$app->post(
    '/admin/filemanager',
    'Orbs\Controllers\FileManagerController:ckUploader'
)->setName('ckUploader');
