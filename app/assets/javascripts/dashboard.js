/**
 * Created by igor on 07/08/15.
 */

$(document).ready(function() {

    $.ajax({
        url: "/temperature/get_data",
        success: function(data, textStatus, jqXHR) {

            console.log("DATA");
            var measures=[];
            var labels=[];
            $.each(data, function( index, value ) {
                measures.push(value['value']/10);
                labels.push(value['created_at']);
            });

            var data = {
                labels: labels,
                datasets: [
                    {
                        label: "My First dataset",
                        fillColor: "rgba(220,220,220,0.2)",
                        strokeColor: "rgba(220,220,220,1)",
                        pointColor: "rgba(220,220,220,1)",
                        pointStrokeColor: "#fff",
                        pointHighlightFill: "#fff",
                        pointHighlightStroke: "rgba(220,220,220,1)",
                        data: measures
                    }
                ]
            };
            var myLineChart = new Chart($("#canvas").get(0).getContext("2d")).Line(data);
        }
    });
});