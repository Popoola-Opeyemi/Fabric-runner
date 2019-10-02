<?php 

namespace Orbs\Core;


use Aura\Sql\ExtendedPdo;
use PDO;


class Db {

      /**
       * The singleton instance of the db 
       *
       */ 
      private static $instance;

      /** 
       * The public interface to the db singleton 
       * @return ExtendedPdo $instance 
       */
      public static function getInstance() {
          if (self::$instance == null) {
              self::$instance = self::getConnection();
          }
          return self::$instance;
      }
      
       /**
        * Private method to get connection 
        * @throws PDOException 
        */
       private static function getConnection() {
           $dbsettings = Config::getInstance();
           $config = $dbsettings->get('database');

           // pgsql db variables
           $dsn = $config['dsn']; 
           $host = $config['host'];
           $port = $config['port'];
           $dbname = $config['dbname'];
           $user = $config['user'];
           $password = $config['password'];
       

            $pdo = new PDO(
                "$dsn:host=$host;port=$port;dbname=$dbname",
                 $user, 
                 $password 
            );

           $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
           $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);

           // Decorate PDO to enable features of Aura.sql 
           $decoratedPdo = new ExtendedPdo($pdo);
           return $decoratedPdo;

       }
     
 }
