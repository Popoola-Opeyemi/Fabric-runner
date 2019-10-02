<?php 

use Orbs\Models\Setting;
use Mailgun\Mailgun;
use Orbs\Core\Config;
use Swift_Message;
use Swift_Image;

class Mailer {
    
    public static function sendMail($type, $dest, $ctx, $view, $tmpl) {
        switch ($type) {
            case "http": 
                static::sendHTTP($dest, $ctx, $view, $tmpl); 
                break; 
            case "smtp": 
                static::sendSMTP($dest, $ctx, $view, $tmpl); 
                break; 
            default:
        }
    }

    /** send mail via http -> $dest, $ctx ['title', 'content', 'user'] and $view Object */
    private static function sendSMTP($dest, $ctx, $view, $tmpl) {
        

        $settingsModel = new Setting;
        $senderSettings = json_decode($settingsModel->getSettings('email')['setting'], true);
        $smtpSettings = json_decode($settingsModel->getSettings('smtp')['setting'], true);
        
        $logo = Swift_Image::fromPath('images/ledrop_logo.png');
        $message = Swift_Message::newInstance($ctx['subject']);
        $cid = $message->embed($logo); 
        $ctx['logo'] = $cid;
        $mailBody = $view->fetch($tmpl, $ctx);

        $transport = Swift_SmtpTransport::newInstance(
            $smtpSettings['host'],
            $smtpSettings['port'],
            'ssl'
        )->setUsername($smtpSettings['username'])
        ->setPassword($smtpSettings['password']);
        $mailer = Swift_Mailer::newInstance($transport);

        $sender = [ $senderSettings['sender_email'] => $senderSettings['sender_name'] ];

        $message->setFrom($sender)->setTo($dest)->setBody($mailBody, 'text/html'); 
        $result = $mailer->send($message);
    }

    /** send mail via http -> $dest, $ctx ['title', 'content', 'user'] and $view Object */
    private static function sendHTTP($dest, $ctx, $view, $tmpl) {

        $settings = new Setting;
        $config = json_decode($settings->getSettings('mailgun')['setting'], true);
        $mailGun = Mailgun::create($config['api_key']);
        $domain = $config['secret'];
        $sender = json_decode($settings->getSettings('email')['setting'], true);
        $subject = $ctx['subject'];
        $mailBody = $view->fetch($tmpl, $ctx);
        $senderEmail = $sender['sender_email'];
        $senderName = $sender['sender_name'];
        $parameters = [
            'from' => "$senderName <$senderEmail>",
            'to' => $dest, // to be changed to the $dest param at production
            'subject' => $subject,
            'html' => $mailBody
        ];
        $result = $mailGun->messages()->send($domain, $parameters);
        return $result;

    }

}
