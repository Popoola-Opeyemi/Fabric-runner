
function showDailyUsage() {

  // line data
  var usage_ctx = document.getElementById('daily_usage');
  var daily_usage = window.daily_usage;
  var daily_usage_data = {
    type: 'line',
    data: {
      labels: daily_usage.labels,
      datasets: [{
        label: "Page usage",
        fill: false,
        lineTension: 0.2,
        backgroundColor: "rgba(75,192,192,0.4)",
        borderColor: "rgba(75,192,192,1)",
        // borderCapStyle: 'butt',
        borderDash: [],
        borderDashOffset: 0.0,
        borderJoinStyle: 'miter',
        pointBorderColor: "rgba(75,192,192,1)",
        pointBackgroundColor: "#fff",
        pointBorderWidth: 1,
        pointHoverRadius: 5,
        pointHoverBackgroundColor: "rgba(75,192,192,1)",
        pointHoverBorderColor: "rgba(220,220,220,1)",
        pointHoverBorderWidth: 2,
        pointRadius: 1,
        pointHitRadius: 10,
        data: daily_usage.values,
        spanGaps: false,
      }]            
    },
    options: {
        scales: {
          xAxes: [{
                        display: true,
                        scaleLabel: {
                            display: true,
                            labelString: ''
                        }
                }],
        },
        responsive: true,
      }
  }
  new Chart(usage_ctx, daily_usage_data); 

  // pie data - browser usage
  var broswer_ctx = document.getElementById('browser');
  var browser_usage = window.browser_usage;
  var browser_usage_data = {
    type: 'pie',
    data: {
      labels: browser_usage.labels,
      datasets: [{
        data: browser_usage.values,
        backgroundColor: ['red', 'orange', 'yellow', 'green', 'green', ],
      }]            
    },
    options: {
        responsive: true,
      }
  }
  new Chart(broswer_ctx, browser_usage_data); 

   // pie data - referers
  var referer_ctx = document.getElementById('referer');
  var top_referers = window.top_referers;
  var referer = {
    type: 'doughnut',
    data: {
      labels: top_referers.labels,
      datasets: [{
        data: top_referers.values,
        backgroundColor: ['green', 'blue', 'yellow', 'orange', 'red', ],
      }]            
    },
    options: {
        responsive: true,
      }
  }
  new Chart(referer_ctx, referer); 


  
  
}
