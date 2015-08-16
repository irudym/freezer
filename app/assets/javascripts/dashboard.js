/**
 * Created by igor on 07/08/15.
 */

var myLineChart;

function updateGraph(year, month, day) {
    if(myLineChart) myLineChart.destroy();
    $.ajax({
        url: "/temperature/get_data",
        data: {year: year, month: month, day: day},
        success: function(data, textStatus, jqXHR) {
            console.log('update graph');
            var graph_data = {
                labels: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23],
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(220,220,220,0.2)",
                        strokeColor: "rgba(220,220,220,1)",
                        pointColor: "rgba(220,220,220,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: data
                    }
                ]
            };
            myLineChart = new Chart($("#canvas").get(0).getContext("2d")).Line(graph_data);
        }
    });
}


function updateTemperature() {
    $.ajax({
        url: "/temperature/get_current",
        success: function(data, textStatus, jqXHR) {
            console.log("Temp: " + data);
            $('.big_number').html(data/10+ " <sup>0</sup>C");
        }
    });
}

$(document).ready(function() {

    //set datepicker
    $(function() {
        $("#datepicker").datepicker();
        $("#datepicker").datepicker().datepicker("setDate", new Date());
    });

    $("#datepicker").datepicker({
        onSelect: function(date, instance) {
            var date = $(this).datepicker('getDate');
            updateGraph(date.getFullYear(), date.getMonth()+1, date.getDate());
        }
    });

    //set width
    $('#canvas').width($('#canvas').parent().width());
    $('#canvas').height('250');

    $( window ).resize(function() {
        $('#canvas').width($('#canvas').parent().width());
        $('#canvas').height('250');
    });
    updateGraph();

    updateTemperature();
    setInterval(updateTemperature, 10000);
});