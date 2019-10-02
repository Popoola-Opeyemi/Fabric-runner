<?php 

namespace Orbs\Core;
use Slim\Views\Twig as SlimTwig;

class Twig extends SlimTwig {

    public function addGlobal($key, $value) {
        $this->environment->addGlobal("$key", $value);
    }
}
