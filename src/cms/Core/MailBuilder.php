<?php 

namespace Orbs\Core;

use Orbs\Models\Setting;
use Swift_Message;

/**
 * Mail builder class with static helper functions to help create mails 
 */
class MailBuilder {

    /**
     * Compose a mail
     * @param $recipient  string email of the user
     * @param $subject string heading of the mail 
     * @param $body string message body
     * @return bool true if sent false if not 
     */
    public static function compose($subject, $body) {
        $settingsModel = new Setting;
        $emailDispatcher = $settingsModel->getEmailDispatcher();
        $message = Swift_Message::newInstance()

            ->setSubject($subject)
            ->setFrom([ $emailDispatcher['setting'] ]) 
            ->setTo( $emailDispatcher['setting'] ) 
            ->setBody($body);
        
        return $message;
    }
}

