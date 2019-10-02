<?php


class Validator {

    /** 
     * Validate required fields takes in a required field and a req
     * then returns an errors for each field if not set or is empty
     */ 
    public static function validate($requiredFields, $postData) {
        $errors = [];
        foreach ($requiredFields as $field) {
            if ($postData[$field] == "") {
                $errors[$field] = "This field is required";
            }
        }
        return $errors;
    }

    /** 
     * check if email already exists given the connection, email, id, field & table  
     * id defaults to zero 
     */
    public static function mailCheck($conn, $table, $field, $email, $id = 0) {
        $sql = "select $field from $table 
                 where email = '$email' and id != $id";
        $stmt = $conn->query($sql);
        $result = $stmt->fetch() ? true : false;
        return $result;
    }

    /** 
     * Validate required fields takes in a required field and a req
     * then returns an errors for each field if not set or is empty
     */ 
     public static function validateFile($file, $maxSize = ( 5 * 1024 * 1024)) {
        $errors = [];
        if (! $file || $file == null) {
            $errors['none'] = 'The uploaded file is not accepted';
            return $errors;
        }
        if ($file->getError() == 4) {
            $errors['nofile'] = 'No file is selected for upload';
        }
        if ($file->getSize() > $maxSize) {
            $errors['size'] = "The file is too large, upload must be less than $maxSize";
        }
        return $errors;
    }


  
}
