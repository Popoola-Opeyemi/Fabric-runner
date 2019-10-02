<?php 

$app->group('/admin/settings', function() {

    $this->get(
        '', 
        'Orbs\Controllers\SettingsController:getAllSettings'
    )->setName('getAllSettings');

   
    $this->post(
        '/email',
        'Orbs\Controllers\SettingsController:updateEmailSettings'
    )->setName('updateEmailSettings');
     $this->post(
        '/timeout',
        'Orbs\Controllers\SettingsController:updateTimeoutSettings'
    )->setName('updateTimeoutSettings');
    $this->post(
        '/smtp',
        'Orbs\Controllers\SettingsController:updateSMTPSettings'
    )->setName('updateSMTPSettings');

});
