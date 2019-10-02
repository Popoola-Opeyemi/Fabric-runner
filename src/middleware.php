<?php
// Application middleware

$app->add(new \Orbs\Middleware\RedirectTrailingSlash()); 

$app->add(new \Orbs\Middleware\AddSessionsToRequests());

$app->add(new \Orbs\Middleware\AnalyticsTrack());

$app->add(new \Orbs\Middleware\RedirectIfNotLoggedIn());

