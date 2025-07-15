

$(function(){ 

  if(!EA.onRailsPage('boat_logs', ['edit', 'new'])) {
    return;
  }
  
  $("#boat_log_date").datepicker({
    format: 'yyyy-mm-dd',
    orientation: "bottom",
    autoclose: true
  });

  $("#boat_log_station_logs_attributes_0_time").timeEntry({ show24Hours: true, minTime: "06:00", maxTime: "20:00" });
  $("#boat_log_station_logs_attributes_1_time").timeEntry({ show24Hours: true, minTime: "06:00", maxTime: "20:00" });

    Number.prototype.toRad = function() {
      return this * Math.PI / 180;
    }


    function getStationDistance() {
      const latitude_fields = $("input.coords[name*='latitude_in_northern_degrees']");
      const longitude_fields = $("input.coords[name*='longitude_in_western_degrees']");

      if (latitude_fields.length < 2 || longitude_fields.length < 2) {
        return;
      }

      var lat2 = parseFloat(latitude_fields.get(1).value);
      var lon2 = -parseFloat(longitude_fields.get(1).value);
      var lat1 = parseFloat(latitude_fields.get(0).value);
      var lon1 = -parseFloat(longitude_fields.get(0).value);
      
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

    $("form").on("keypress", "input.coords-positive", function(e) {
      // Disallow non-digit, non-decimal key presses
      if (!e.key.match(/[\d\.]+/)) {
        e.preventDefault();
      }
    });
    $("form").on("paste", "input.coords", function(e) {
      // Attempt to automatically parse commonly pasted lat,lng formats into the
      // appropriate fields automatically.
      const $this = $(this);

      const data = e.originalEvent.clipboardData.getData("text/plain");
      if (!data) {
        return;
      }

      // https://rubular.com/r/4mnJE01XI7Zrjy
      //
      // Formats supported:
      // * 25.123,-85.123
      // * 25.123 -85.123
      // * 25.123N 85.123W
      // * N17.74722 W64.70563
      const parts = data.match(/^\s*[NS]?([-0-9\.]+)[NS]?[\s,]+[EW]?([-0-9\.]+)[EW]?\s*$/)
      if (!parts) {
        return;
      }

      // Do not allow the paste to proceed as usual. We are taking over and
      // doing some parsing.
      e.preventDefault();

      const latitude = parts[1].replace(/[^0-9\.]+/g, "");
      const longitude = parts[2].replace(/[^0-9\.]+/g, "");

      const $closestLatitudeField = $this.closest("div.row").find("input[name*='latitude']");
      const $closestLongitudeField = $this.closest("div.row").find("input[name*='longitude']");

      $closestLatitudeField.val(latitude);
      $closestLongitudeField.val(longitude).trigger("focus").trigger("change").trigger("input");
    });

    getStationDistance();
    $("form").on("change", "input.coords", function(){
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


  //function alert24HourClock() {
    //$(".boatlog_time").on("focusout", function(){
      //var $time = $(this).val();
      //var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      //var $time2 = parseInt(b, 10);
      //if ( $time2 >= "700" && $time2 <= "1900" ){
      
      //} else { alert("why are you diving in the dark?"); }
    //});
  //};

  //alert24HourClock();
});
