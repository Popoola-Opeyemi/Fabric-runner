<?php
// Routes

$app->get(
    '/admin',
    'Orbs\Controllers\AnalyticController:getAnalytics' 
)->setName('admin');
//

