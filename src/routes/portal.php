<?php

use Orbs\Middleware\PortalGate;

$app->group('/portal', function() {

    // portal home
    $this->get(
        '',
        'Orbs\Controllers\PortalController:portalHome'
    )->setName('portalHome');

    // transaction 
    $this->get(
        '/transactions',
        'Orbs\Controllers\PortalController:transactions'
    )->setName('transactionPage');

    // buy 
    $this->get(
        '/buy',
        'Orbs\Controllers\PortalController:buy'
    )->setName('buy');
    $this->post(
        '/make-payment',
        'Orbs\Controllers\PortalController:makePayment'
    )->setName('makePayment');

    // sell
    $this->get(
        '/sell',
        'Orbs\Controllers\PortalController:sell'
    )->setName('sell');
    $this->post(
        '/sell-currency',
        'Orbs\Controllers\PortalController:sellCurrency'
    )->setName('sellCurrency');

    // profile 
    $this->get(
        '/profile',
        'Orbs\Controllers\PortalController:profile'
    )->setName('profile');
    $this->post(
        '/profile-details',
        'Orbs\Controllers\PortalController:updateDetails'
    )->setName('updateDetails');
    $this->post(
        '/profile-password',
        'Orbs\Controllers\PortalController:updatePassword'
    )->setName('updatePassword');

    // accounts 
    $this->get(
        '/accounts',
        'Orbs\Controllers\PortalController:portalAccounts'
    )->setName('portalAccounts');
    $this->get(
        '/accounts/{id}',
        'Orbs\Controllers\PortalController:subscriberAccounts'
    );
    $this->post(
        '/accounts',
        'Orbs\Controllers\PortalController:addAccount'
    )->setName('addAccount');

    $this->get(
        '/accounts/edits/{id}',
        'Orbs\Controllers\PortalController:editFormPage'
    );
    $this->post(
        '/accounts/edit/{id}',
        'Orbs\Controllers\PortalController:updateAccount'
    )->setName('updateAccount');

    $this->post(
        '/accounts/delete/{id}',
        'Orbs\Controllers\PortalController:deleteAccount'
    )->setName('deleteAccount');

})->add( new PortalGate() );
