

$(function(){ 

  if(!EA.onRailsPage('boat_logs', ['edit', 'new'])) {
    return;
  }
  
  if ( $('body').hasClass('new') ) {
    $("#boat_log_date").datepicker("setDate", new Date());
  };
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


  function setDiverTypeLabelOnLoad() {
    $(".diver_type_label").each(function(){
      var $rep_type = $(this).closest(".replicate_record").find(".replicate_type :input").val().toUpperCase();
      if ( $rep_type == "A" || $rep_type == "B") {
        $(this).text("Fish Diver"); 
        } 
      else if ( $rep_type == "I" || $rep_type == "J") {  
        $(this).text("LPI Diver"); 
        }
      else if ( $rep_type == "X" || $rep_type == "Y") {  
        $(this).text("Demo Diver"); 
        }
      else { $(this).text("Diver"); };
    });
  };

  function setDiverTypeLabel() {
    $(".replicate_type :input").on('focusout', function() {
      setDiverTypeLabelOnLoad();
    });
  };

  setDiverTypeLabelOnLoad();
  setDiverTypeLabel();
  $(document).delegate(".add_nested_fields", "click", function(){ 
    setDiverTypeLabel();
  });
  
  jQuery.validator.addMethod("lettersonly", function(value, element) {
    return this.optional(element) || /[a-zA-Z]+$/.test(value);
  }, "Only one letter");


  $(".new_boat_log, .edit_boat_log").validate({

      errorElement: "span",


      onfocusout: function(element) {
        this.element(element);
      },

        rules: {
                'boat_log[boatlog_manager_id]': {
                         required: true
                       },
                'boat_log[date]': {
                         required: true
                       },
                'boat_log[primary_sample_unit]': {
                         required: true,
                         number: true,
                         minlength: 4,
                         maxlength: 4
                       }

               },
        messages: {

                  }
    });


    function validate_fields() {
      $('[name*="stn_number"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          minlength: 1,
          maxlength: 1
        });
      });
      $('[name*="latitude"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="longitude"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="replicate"]').each(function(){
        $(this).rules('add', {
          required: true,
          lettersonly: true,
          maxlength: 1
        });
      });
      $('[name*="diver_id"]').each(function(){
        $(this).rules('add', {
          required: true
        });
      });
      $('[name*="comments"]').each(function(){
        $(this).rules('add', {
          maxlength: 140
        });
      });
    };

    validate_fields();
    $(document).delegate(".add_nested_fields", "click", function(){ 
      validate_fields();
    });


  function alert24HourClock() {
    $(".boatlog_time").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 >= "700" && $time2 <= "1900" ){
      
      } else { alert("why are you diving in the dark?"); }
    });
  };

  alert24HourClock();
});
