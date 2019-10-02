<?php

// :: PAGE ROUTES
// All page routes -- prefixed by admin/page
 $app->group('/admin/page', function () {

    // GET route to get a list of pages
    $this->get(
      '',
      'Orbs\Controllers\PageController:listPages'
    )->setName('listPages');

    // GET route to create a new page
    $this->get(
      '/create',
      'Orbs\Controllers\PageController:getCreatePage'
    )->setName('getCreatePage');

    // POST route to post page creation details
    $this->post(
      '/create',
      'Orbs\Controllers\PageController:postCreatePage'
    )->setName('postCreatePage');


    // POST route to update page update details
    $this->post(
      '/edit/{id}',
      'Orbs\Controllers\PageController:postUpdatePage'
      )->setName('postUpdatePage');

      // POST route to update page update details
    $this->post(
      '/publish/{id}',
      'Orbs\Controllers\PageController:publishPage'
    )->setName('publishPage');

    // GET route to view a page & to edit
    $this->get(
      '/edit/{id}',
      'Orbs\Controllers\PageController:getEditPage'
    )->setName('getEditPage');

    // POST route to delete a page
    $this->post(
      '/{id}/delete',
      'Orbs\Controllers\PageController:deletePage'
    )->setName('deletePage');

    $this->post(
        '/search',
        'Orbs\Controllers\PageController:searchPage'
    )->setName('searchPage');
    $this->get(
        '/search/{term}',
        'Orbs\Controllers\PageController:getSearchPage'
    )->setName('getSearchPage');

 });

