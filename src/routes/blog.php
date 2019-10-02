<?php 

$app->group('/admin/blog', function(){
    // for Posts
    $this->get(
        '',
        'Orbs\Controllers\PostController:Posts'
    )->setName('Posts');

    $this->get(
        '/create',
        'Orbs\Controllers\PostController:CreatePostForm'
    )->setName('CreatePostForm');
    $this->post(
        '/create',
        'Orbs\Controllers\PostController:SavePost'
    )->setName('SavePost');

    $this->get(
        '/post/{id}',
        'Orbs\Controllers\PostController:Post'
    )->setName('GetPost');
    $this->post(
        '/post/{id}',
        'Orbs\Controllers\PostController:UpdatePost'
    )->setName('UpdatePost');


    $this->post(
        '/delete/{id}',
        'Orbs\Controllers\PostController:DeletePost'
    )->setName('DeletePost');
    $this->post(
        '/publish/{id}',
        'Orbs\Controllers\PostController:PublishPost'
    );

    $this->post(
        '/category',
        'Orbs\Controllers\PostController:AddCategory'
    );
    $this->post(
        '/category/edit/{id}',
        'Orbs\Controllers\PostController:EditCategory'
    );

    $this->get(
        '/comments/{post_id}',
        'Orbs\Controllers\PostController:commentsPerPost'
    )->setName('commentsPerPost');
    $this->post(
        '/comments/toggle/{comment_id}',
        'Orbs\Controllers\PostController:togglePostComment'
    )->setName('togglePostComment');
    $this->post(
        '/comments/delete/{comment_id}',
        'Orbs\Controllers\PostController:deleteCommment'
    )->setName('deleteComment');

});

$app->get(
    '/news/{url}',
    'Orbs\Controllers\FrontendController:onePost'
)->setName('onePost');
$app->post(
    '/blog/{url}',
    'Orbs\Controllers\FrontendController:addComment'
)->setName('addComment');

