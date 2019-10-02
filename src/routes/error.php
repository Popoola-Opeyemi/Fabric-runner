<?php 

$app->get(
    '/500', 
    'Orbs\Controllers\FrontendController:error500'
);
$app->get(
    '/404',
    'Orbs\Controllers\FrontendController:error404'
);
