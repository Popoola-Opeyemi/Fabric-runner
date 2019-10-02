<?php 

// =======================================
// Backend authentication for users 
// =======================================
$app->group('/admin', function () {
    // GET route for login 
    $this->get(
        '/login', 
        'Orbs\Controllers\Auth\AuthController:getLogin'
    )->setName('getLogin');
    // POST route for login 
    $this->post(
        '/login', 
        'Orbs\Controllers\Auth\AuthController:postLogin'
    )->setName('postLogin');
    // POST route for logout 
    $this->post(
        '/logout', 
        'Orbs\Controllers\Auth\AuthController:postLogout'
    )->setName('postLogout');
    // GET route for password reset form
     $this->get(
         '/reset-password', 
         'Orbs\Controllers\Auth\AuthController:getResetPasswordForm'
    )->setName('getResetPasswordForm');
    // POST route for password reset action
     $this->post(
         '/reset-password', 
         'Orbs\Controllers\Auth\AuthController:postResetPasswordForm'
    )->setName('postResetPasswordForm');
    // GET route to set a new password
     $this->get(
        '/reset-password/{token}',
        'Orbs\Controllers\Auth\AuthController:setNewPassword'
    )->setName('setNewPassword');
    // POST route to set a new password 
    $this->post(
        '/reset-password/{token}',
        'Orbs\Controllers\Auth\AuthController:resetPassword'
    )->setName('resetPassword');
});

// =======================================
// Frontend auth 
// =======================================
$app->get(
    '/login',
    'Orbs\Controllers\FrontendController:loginPage'
)->setName('loginPage');
$app->get(
    '/request-access',
    'Orbs\Controllers\FrontendController:signUpPage'
)->setName('signUpPage');
$app->post(
    '/login',
    'Orbs\Controllers\FrontendController:postSubscriberLogin'
)->setName('postSubscriberLogin');
$app->post(
    '/request-access',
    'Orbs\Controllers\FrontendController:postSubscriberSignUp'
)->setName('postSubscriberSignUp');
$app->get(
    '/sign-up-success',
    'Orbs\Controllers\FrontendController:signUpSuccess'
)->setName('signUpSuccess');
$app->get(
    '/verification/{token}',
    'Orbs\Controllers\FrontendController:verifyUser'
)->setName('verifySubscriber');
$app->post(
    '/logout',
    'Orbs\Controllers\FrontendController:logoutUser'
)->setName('logoutSubscriber');

// subscriber password reset routes 
$app->get(
    '/password-reset',
    'Orbs\Controllers\FrontendController:resetSubscriberPasswordForm'
)->setName('resetSubscriberPasswordForm');
$app->post(
    '/password-reset',
    'Orbs\Controllers\FrontendController:postSubscriberPasswordReset'
)->setName('postSubscriberPasswordReset');
$app->get(
    '/password-reset/{token}',
    'Orbs\Controllers\FrontendController:newPasswordResetForm'
)->setName('newPasswordResetForm');
$app->post(
    '/password-reset/{token}',
    'Orbs\Controllers\FrontendController:passwordResetUpdate'
)->setName('passwordResetUpdate');
