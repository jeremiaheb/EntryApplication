

$(function(){ 
  
  $("#boat_log_date").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  $("#boat_log_station_logs_attributes_0_time").timeEntry({ show24Hours: true });
  $("#boat_log_station_logs_attributes_1_time").timeEntry({ show24Hours: true });

});
