

$(function(){ 
  
  $("#boat_log_date").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  $("#boat_log_station_logs_attributes_0_time").timeEntry({ show24Hours: true });
  $("#boat_log_station_logs_attributes_1_time").timeEntry({ show24Hours: true });

    Number.prototype.toRad = function() {
      return this * Math.PI / 180;
    }


    function getStationDistance() {
      var lat2 = parseFloat($('#boat_log_station_logs_attributes_1_latitude').val()); 
      var lon2 = parseFloat($('#boat_log_station_logs_attributes_1_longitude').val()); 
      var lat1 = parseFloat($('#boat_log_station_logs_attributes_0_latitude').val());
      var lon1 = parseFloat($('#boat_log_station_logs_attributes_0_longitude').val());
      
      var R = 6371000; // m 
      //has a problem with the .toRad() method below.
      var x1 = lat2-lat1;
      var dLat = x1.toRad();  
      var x2 = lon2-lon1;
      var dLon = x2.toRad();  
      var a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
                      Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
                      Math.sin(dLon/2) * Math.sin(dLon/2);  
      var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
      var d = R * c; 
      
      $('.distanceBetweenStations').text(d.toFixed(0))
    };

    getStationDistance();
    $('.coords').change(function(){
      getStationDistance();
    });




});
