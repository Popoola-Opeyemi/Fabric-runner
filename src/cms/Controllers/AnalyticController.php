<?php 

namespace Orbs\Controllers;

use Orbs\Models\Analytic;
use Auth; 

class AnalyticController extends Controller {

    public function getAnalytics($req, $res, $args) {
        $template = 'admin/dashboard.twig';
        $domain = $req->getQueryParam('domain', 1); 
        $analyticModel = new Analytic;

        $dailyUsage = $analyticModel->dailyUsage($domain);
        $browserUsage = $analyticModel->browserUsage($domain);
        $pageTotals = $analyticModel->totalPageViews($domain);
        $topReferers = $analyticModel->topFiveReferers($domain);
        $memberStats = $analyticModel->getMemberStats(); 

        
        $ctx = [
            "daily_usage" => json_encode($dailyUsage, true),
            "browser_usage" => json_encode($browserUsage, true),
            "page_totals" => $pageTotals,
            "top_referers" => json_encode($topReferers, true),
            "memberStats" => $memberStats,
        ];

        $response = $this->view->render($res, $template, $ctx);
        return $response;
    }

}

