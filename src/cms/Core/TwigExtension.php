<?php

namespace Orbs\Core;

use Slim\Views\TwigExtension as SlimViewExtension;
use Carbon\Carbon;
use Helper;

class TwigExtension extends SlimViewExtension {

    public function getFunctions() {
        $slimFunctions = parent::getFunctions();
        return array_merge(
            $slimFunctions,
            [
                new \Twig_SimpleFunction('human_time', array($this, 'humanTime')),
                new \Twig_SimpleFunction('request_is', array($this, 'requestIs')),
                new \Twig_SimpleFunction('widget_name_proc', array($this, 'widgetNameProc')),
                new \Twig_SimpleFunction('join_names', array($this, 'joinNames')),
                new \Twig_SimpleFunction('number_format', array($this, 'numberFormat')),
                new \Twig_SimpleFunction('ngn', array($this, 'nairaSign')),
                
            ]
        );
    }

    /** 
     * {{ human_time(date|date('d-m-Y H:i:s')) }}
     */
    public function humanTime($date) {
      $a = Carbon::createFromFormat('d-m-Y H:i:s', $date);
      return $a->diffForHumans();
    }

   
    /**
     *
     * @param $name (paramA) -> a string with a dash '-',
     * @param $str (paramB) -> a string 
     *
     * The function replaces the second to the last in the array of strings generated from the first parameter 
     * using explode('-', paramA) with paramB, and shifting the last string replaced to the last item
     * use thus -> $newName = widget_name_proc('Burno-Barno', 'BEM'); // $newName becomes 'Burno-BEM-Barno' & 
     * widget_name_proc('Adamu-singer-juliet', 'james') returns // 'Adamu-singer-james-juliet'
     * in twig template this function is available as [widget_name_proc(params...)]
     *
     * @return string
     */
    public function widgetNameProc($name, $str) {
        $parts = explode("-", $name);
        array_splice($parts, -1, 0, array($str));

        return implode("-", $parts);
    }

    /**
     * @param $name (paramA) -> a string with with a dash '-',
     * @param $str (paramB) -> a string 
     * use thus -> $newName = joinNames('Uzondu-Enudeme', 'Will'); // $newName becomes Enudeme-Will
     * in twig template this function is available as [join_names(params...)]
     * @return string
     */
    public function joinNames($name, $str) {
        $parts = explode('-', $name);
        $pieces = [$parts[1], $str];
        return implode("-", $pieces);
    }

    public function requestIs($name) {
        // todo implement with regex 
    }

    public function numberFormat($figure) {
        return number_format($figure, 2);
    }

    // the naira sign 
    public function nairaSign() {
        return "&#8358;";
    }


}

