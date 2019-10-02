<?php 

$app->group('/admin', function() {

    $this->get(
        '/announcement', 
        'Orbs\Controllers\AnnouncementController:showAnnouncements'
    )->setName('showAnnouncements');

    $this->get(
        '/announcement/create',
        'Orbs\Controllers\AnnouncementController:getAnnouncementForm'
    )->setName('getAnnouncementForm');

    $this->get(
        '/announcement/edit/{id}',
        'Orbs\Controllers\AnnouncementController:getEditAnnouncementForm'
    )->setName('getEditAnnouncementForm');

    $this->post(
        '/announcement/create',
        'Orbs\Controllers\AnnouncementController:postAnnouncementForm'
    )->setName('postAnnouncementForm');

});
