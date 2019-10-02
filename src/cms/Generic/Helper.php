<?php

use Dflydev\ApacheMimeTypes\PhpRepository as MimeType;

class Helper {

    /** 
     * toUrl converts an input to a the form x-xx-xxx after trimming both ends of the input
     * @param $value string 
     * @return string 
     */
    public static function toUrl($value) {
        $str =  '",.-:;/\'!@#$%^&*()+=[]{}|<>?`~ ';
        $notAllowed = str_split($str);
        return strtolower(str_replace($notAllowed, '-', trim($value)));
    }

    /** 
     * Hash password using CRYPT_BLOWFISH algorithm 
     *
     * @param $password 
     *  @return $hashedPassword string 60 characters long 
     */
     public static function hashPassword($password) {
         $option = ['cost' => 10 ];
         return password_hash($password, PASSWORD_BCRYPT, $option);
     }

     /** 
      * Verify a hashed password 
      * 
      * @param $password string
      * @param $hashedPassword string 
      *
      * @return bool (true if matches, false if not)
      */
      public static function verifyPassword($password, $hash) {
          return password_verify($password, $hash);
      }

    /** 
     * Returns a human readable file size suffixed with the measurement unit 
     */
    public static function human_fileSize($bytes, $decimals = 2) {

        $size = ['B', 'kB', 'MB', 'GB',];
        $factor = floor((strlen($bytes) - 1) / 3);

        return sprintf("%.{$decimals}f", $bytes / pow(1000, $factor)) .@$size[$factor];
    }

    /** 
     * Generates a hash function -- no certainty of a unique return value 
     */
    public static function genHash($hashLength) {

        $alphanumericNum = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
        $length = strlen($alphanumericNum);
        $length--;
        $hash = null;
        for ($i = 1; $i <= $hashLength; $i++) {
            $position = mt_rand(0, $length);
            $hash .= substr($alphanumericNum, $position, 1);
        }
        return $hash;
    }
    
    /** 
     * Generate random uuid - perfect for unique id generation 
     * made of --> prefix:timestamp:uuid
     */
    public static function genRandom_uuid($length = 5, $prefix='O') {
        $random_id = self::genHash($length);
        $random_id .= chr(rand(65, 90));
        $random_id .= substr(time(), $length);
        $random_id .= substr(uniqid($prefix), $length);
        return $random_id;
    }
    
    /** 
    * generate an objectId like that of mongodb -- with a 12bytes long string 
    */
    public static function genObjectId($timestamp) {
        // 12 bytes long 
        static $inc = 0;
        $ts = pack('N', $timestamp); // 4 bytes 
        $m = substr(md5(gethostname()), 0, 3); // 3 bytes 
        $pid = pack('n', posix_getpid()); // 3 bytes 
        $trail = substr(pack('N', ++$inc), 1, 3); // 2 bytes
        $bin = sprintf("%s%s%s%s", $ts, $m, $pid, $trail);
        $id = '';
        for ($i = 0; $i < 12; $i++) {
            $id .= sprintf("%02X", ord($bin[$i]));
        }
        return $id;
    }

    /**  
     * get three input string in the form of Y -> 2006, m -> 1, d -> 23
     * returns a php datetime in format Y-m-d H:i:s 
     */
    public static function stringsToDate($y, $m, $d) {
        if ($y == "" || $m == "" || $d == "") { return ""; }
        if ($m == 2 && self::isLeapYear($y)) { return ""; }
        $dateString = $y . '-' . $m . '-' . $d;
        $date = new DateTime($dateString);
        return $date->format('Y-m-d');
    }


    /**  
     * takes a php datetime formated date Y-m-d H:i:s 
     * returns a slice of string ==>  the form of Y -> 2006, m -> 1, d -> 23
     */
    public static function dateToStrings($date) {
        if ($date == "") { return []; }
        $date = new DateTime($date);
        return [
            'year' => $date->format('Y'),
            'month' => $date->format('m'),
            'day' => $date->format('d'),
        ];
    }


    /** 
     * Returns if a year is leapYear 
     */
    private static function isLeapYear($year) {
        return $year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0);
    }

    /** 
     * months are listed here as they remain static and wouldn't change 
     */
    public static function getMonths() {
        return [
            ['id' => 1, 'name' => 'January'],
            ['id' => 2, 'name' => 'February'],
            ['id' => 3, 'name' => 'March'],
            ['id' => 4, 'name' => 'April'],
            ['id' => 5, 'name' => 'May'],
            ['id' => 6, 'name' => 'June'],
            ['id' => 7, 'name' => 'July'],
            ['id' => 8, 'name' => 'August'],
            ['id' => 9, 'name' => 'September'],
            ['id' => 10, 'name' => 'October'],
            ['id' => 11, 'name' => 'November'],
            ['id' => 12, 'name' => 'December'],
        ];
    }

    
   /** 
     *
     * upload a file to a destination providing the max size and the data
     *
     * @param $file UploadedFileInterface 
     * @param $maxSize Int default is 5mb 
     * @param $destination String 
     * @return Array|null  if successful or null otherwise
     * the new name is internally generated and should be unique
     */
     public static function uploadFile($file, $fileLabel, $destination = 'uploads/files/') {
        
        if ($file) {

            $fileInfo = pathinfo($file->getClientFileName());
            // file extension
            $extension = $fileInfo['extension'];
            $fileType = $file->getClientMediaType();
            // file type eg. jpg | png ... 
            $type = (new MimeType)->findExtensions($fileType)[0];
            // generated random file name catenating - basename + random_uuid + extension 
            $fileName = substr($fileInfo['basename'], 0, 7) . Helper::genRandom_uuid() . '.' . $extension;
            // human readable file size 
            $fileSize = $file->getSize();
            $size = Helper::human_fileSize($fileSize);
            // fileUrl only for upload destination
            $fileUrl = $destination  . $fileName;
            $payload = [
                'size' => $size,
                'url' => $fileName,
                'name' => $fileLabel,
                'type' => $type
            ];
            
            $file->moveTo($fileUrl);
            return $file->getError() == UPLOAD_ERR_OK ? $payload : null;
        } 
        return null;
     }


     public static function deleteFile($name, $directory = 'uploads/files/') {
        $target = $directory . $name;
        unlink($target);
     }

     public static function validateMsgTmpl($message, $keys, $pattern = ["{{", "}}"]) {
        $errors = [];
        foreach ($keys as $key) {
            $syntax = $pattern[0] . $key . $pattern[1];
            if (! strpos($message, $syntax)) {
                $errors[$key] = "$syntax must be in content";
            }
        }
        return $errors;
     }

}
