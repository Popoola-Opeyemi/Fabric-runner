<?php

$app->group('/admin', function() {

    $this->get(
        '/widgets',
        'Orbs\Controllers\WidgetController:showWidgets'
    )->setName('showWidgets');

    $this->get(
        '/widgets/create',
        'Orbs\Controllers\WidgetController:getCreateWidget'
    )->setName('getCreateWidget');

    $this->post(
        '/widgets/create',
        'Orbs\Controllers\WidgetController:postCreateWidget'
    )->setName('postCreateWidget');

    $this->get(
      '/widgets/edit/{id}',
      'Orbs\Controllers\WidgetController:getEditWidget'
    )->setName('getEditWidget');

    $this->post(
        '/widget/edit/{id}',
        'Orbs\Controllers\WidgetController:postUpdateWidget'
    )->setName('postUpdateWidget');  

    $this->post(
        '/widgets/delete/{id}',
        'Orbs\Controllers\WidgetController:deleteWidget'
    )->setName('deleteWidget');

});

