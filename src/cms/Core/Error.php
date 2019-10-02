<?php

namespace Orbs\Core;

use Slim\Handlers\PhpError as SlimError;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Monolog\Logger;
/**
 * Extending slim error 
 */

final class Error extends SlimError {

    private $logger;

    public function __construct(Logger $logger) {
        $this->logger = $logger;
    }

    public function __invoke(ServerRequestInterface $request, ResponseInterface $response, \Throwable $error) {
        $this->displayErrorDetails = true;
        $this->logger->addInfo(
            $this->renderHtmlErrorMessage($error)
        );

        return $response->withRedirect('/500');
    }
}
