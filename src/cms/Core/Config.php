<?php 

namespace Orbs\Core;

use Orbs\Exceptions\NotFoundException;

/**
* @package Orbs CMS 
*/
class Config {
    /**
     * The  private config object instance
     * 
     */
     private static $instance;

     /**
      * The private data container
      *
      */
      private $data;

      /**
       * Constructs an instance of the config class 
       */
       private function __construct() {
           $json = file_get_contents(__DIR__ . '/../../../app.json');
           $this->data = json_decode($json, true);
       }
      
      /**
       * Getter function for Config instance 
       * @return static -- a singleton
       */
       public static function getInstance() {
           if (self::$instance == null) {
               self::$instance = new Config();
           }
           return self::$instance;
       }

       /** 
        * Get a values for a given key 
        *
        * @param string $key
        * @return array of key - value
        */
        public function get($key) {
            if (!isset($this->data[$key])) {
                throw new NotFoundException("key $key not found in config");
            }
            return $this->data[$key];
        }

}
