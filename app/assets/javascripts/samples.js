$(function(){

  
  if(!EA.onRailsPage('samples', ['edit', 'new'])) {
    return;
  }


    $("#speciesSection").hide();
    $(".changeSection").change(function() {
      // hide
      $("div.sectionDiv").hide();
      // val is something like #div1 or #div2
      var targetId = $(this).val();
      // show the new selected one
      $("#"+targetId).show();
  });
   
    if ( $("form").hasClass("new_sample") ) {
    $(".changeSection option[value='speciesSection']").attr("disabled", "disabled");
    }; 

    function show_or_hide_species(){

      var should_display_substrate = new Array();
      var errorCount = $('#sampleSection :input.error').length;
      
      $('#sampleSection').find('.tab_1').each(function(){
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ( $(this).val() == '' )
          {
            should_display_substrate.push( $(this) );
          };
      });

      if ( should_display_substrate.length == 0 && $("#abiotic_percentage_total").hasClass("one_hundred_ok_flag") && errorCount == 0)
        { 
          $(".changeSection option[value='speciesSection']").removeAttr("disabled");
          $('#gotoSpecies').attr('disabled', false);
        } else {
          $(".changeSection option[value='speciesSection']").attr("disabled", true);
          $('#gotoSpecies').attr('disabled', true);
        };
    };


    $('#gotoSpecies').click(function(){
      $('#sampleSection').hide();
      $('#speciesSection').show();
      $('.changeSection').val('speciesSection');
    });

    //Show or hide sections
    if ( $("form").hasClass("new_sample") ) {
     show_or_hide_species();
    }; 

    //on change check if section should show
     $('.tab_1, .abiotic_percentage').focusout(function(){ 
        show_or_hide_species();
    });

  function calculate_totals( input_class_to_sum, id_to_display_total){
  
        var sum_for_display_total = new Array();
  
        $('.section_1').find('.' + input_class_to_sum ).each(function(){
          if ( $(this).val() != 0 )
            {
              sum_for_display_total.push( $(this).val() );
            };
        });
  
        var total = 0;
  
        $.each(sum_for_display_total,function() {
            total += parseFloat( this );
        });
  
      // If total is greater than 100 then flag it by add a red background.
        if ( total != 100 )
          {
            $( '#' + id_to_display_total).removeClass('one_hundred_ok_flag');
            $( '#' + id_to_display_total).addClass('one_hundred_flag');
          }
        else
          {
            $( '#' + id_to_display_total).addClass('one_hundred_ok_flag');
            $( '#' + id_to_display_total).removeClass('one_hundred_flag');
          }
  
        $( '#' + id_to_display_total).val( total ); 
      };    

    // Calculate total for 'abiotic_footprint' when page loads
    calculate_totals('abiotic_percentage', 'abiotic_percentage_total' );

    // Calculate total for 'abiotic_footprint' on change
    $('.abiotic_percentage').change(function(){
        calculate_totals( 'abiotic_percentage', 'abiotic_percentage_total' );
    });


  function set_time_seen_field_on_focus(){
      $('.sppCommon').on('open', function(){
        var $thisID = $(this).attr('id').slice(0, -10);
        var $radioTimeSeenVal = $('.time_seen_button[class*="active"]').val();

        $('input#' + $thisID + '_time_seen').attr('value', $radioTimeSeenVal );
        $('input#' + $thisID + '_number_individuals').attr('class', 'timeSeen_' + $radioTimeSeenVal);
        $('input#' + $thisID + '_average_length').attr('class', 'timeSeen_' + $radioTimeSeenVal);
        $('input#' + $thisID + '_min_length').attr('class', 'timeSeen_' + $radioTimeSeenVal);
        $('input#' + $thisID + '_max_length').attr('class', 'timeSeen_' + $radioTimeSeenVal);
      });  
  };

    set_time_seen_field_on_focus();
     
     $(document).delegate(".add_nested_fields", "click", function(){ 
        set_time_seen_field_on_focus();
        enable_disable_animals_fields();
        alertSpeciesSizes();
        //$(".section_3 input:text:visible").eq(-5).focus();
        $(".section_3 input:text:visible").eq(-5);
        $(".section_3 .sppCommon:visible").last().select2('open');
        $('#animals').scrollTop($("#animals")[0].scrollHeight);


   });


  $("#animals").find(".sppCommon").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".sppCommon").select2();
  });



  function enable_disable_animals_fields_on_load(){
    $("#animals").find(".fields [id$=number_individuals]").each(function(){
      var $indValue = $(this).val();
      var $recordID = $(this).attr('id');
      var $mean = $recordID.replace('_number_individuals', '_average_length');
      var $min = $recordID.replace('_number_individuals', '_min_length');
      var $max = $recordID.replace('_number_individuals', '_max_length');

        if ($indValue >= 3) {
          $('input#' + $mean).attr('disabled', false)
          $('input#' + $min).attr('disabled', false)
          $('input#' + $max).attr('disabled', false)
      } else if ($indValue == 1) {
          $('input#' + $mean).attr('disabled', false)
          $('input#' + $min).attr('disabled', true)
          $('input#' + $max).attr('disabled', true)
      } else if ( $indValue == 2 ){
          $('input#' + $mean).attr('disabled', true)
          $('input#' + $min).attr('disabled', false)
          $('input#' + $max).attr('disabled', false)
      }
    });
  };

  function enable_disable_animals_fields(){
    $("[id$=number_individuals]").on('focusout', function(){  
    var $indValue = $(this).val();
    var $recordID = $(this).attr('id');
    var $mean = $recordID.replace('_number_individuals', '_average_length');
    var $min = $recordID.replace('_number_individuals', '_min_length');
    var $max = $recordID.replace('_number_individuals', '_max_length');

      if ($indValue >= 3) {
        $('input#' + $mean).attr('disabled', false)
        $('input#' + $min).attr('disabled', false)
        $('input#' + $max).attr('disabled', false)
        $('input#' + $mean).focus()
    } else if ($indValue == 1) {
        $('input#' + $mean).attr('disabled', false)
        $('input#' + $min).val("")
        $('input#' + $min).attr('disabled', true)
        $('input#' + $max).val("")
        $('input#' + $max).attr('disabled', true)
        $('input#' + $mean).focus()
    } else if ( $indValue == 2 ){
        $('input#' + $mean).val("").attr('disabled', true)
        $('input#' + $min).attr('disabled', false)
        $('input#' + $max).attr('disabled', false)
        $('input#' + $min).focus()
    }
    });
  };
  
  enable_disable_animals_fields_on_load();
  enable_disable_animals_fields();


  $("#validateAnimals").click(function(){
    $('.validateIcon').empty();
    
    $('#animals').find('input:enabled').each(function(){
      $('.new_sample, .edit_sample').validate().element(this);
    });
       
    if ( $('#animals').find('input:visible.error').length > 0 ) {
      $('.validateIcon').prepend('<img src="/assets/cross.png"/>');
    } else { 
      $('.validateIcon').prepend('<img src="/assets/check.png" />'); 
      $('#submitButton').attr('disabled', false);
    }
  });

  $("#submitButton").click(function(e) {
    e.preventDefault();
    $(this).attr('disabled',true);

    $(".new_sample, .edit_sample").validate().cancelSubmit = true;
    $(".formContainer :input").not(this).attr('disabled', false);
    $(".new_sample, .edit_sample").submit();
  });




    $("#animals").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
        $(".add_nested_fields").trigger("click");
      }
    });
    
    $("#sample_sample_date").datepicker({format: 'yyyy-mm-dd'});
    $("#sample_dive_begin_time").timeEntry({ show24Hours: true });
    $("#sample_dive_end_time").timeEntry({ show24Hours: true });
    $("#sample_sample_begin_time").timeEntry({ show24Hours: true });
    $("#sample_sample_end_time").timeEntry({ show24Hours: true });



    $.validator.addMethod("fieldID",function(value,element){
        return this.optional(element) || /^\d{5}[a-zA-Z]$/i.test(value); 
      },"FieldID is wrong format"
    );



    $.validator.addMethod("greaterThan", function(value, element, params){
      return value > $(params).val();
    });
    
    $.validator.addMethod("before", function(value, element, params){
      return value < $(params).val();
    });

    $.validator.addMethod("lessThanEqualTo", function(value, element, params){
      return value <= $(params).val();
    });
    
// Check that a species record does not have overlapping sizes with another
// record of the same species

    $.validator.addMethod("doesNotHaveOverlap", function(value, element, params){
      var spp = {}
      var $index = $(element).parent().parent().index();

      var container = $(element).closest('li')
      var $thisSpecies = container.find('.sppCommon').select2("val");

      //var $thisSpecies = $(element).parent().find('.sppCommon').select2("val");
      var $thisNumber = container.find('[id$="number_individuals"]').val();
      var $thisMean = container.find('[id$="average_length"]').val();
      var $thisMin = container.find('[id$="min_length"]').val();
      var $thisMax = container.find('[id$="max_length"]').val();

      var $thisRange

      if ( $thisNumber == 1 ){
        $thisRange = [parseFloat($thisMean)];	
      } else if ( $thisNumber == 2 ) {
        $thisRange = [parseFloat($thisMin), parseFloat($thisMax)];		
      } else if ( $thisNumber == 3 ) {
        $thisRange = [parseFloat($thisMean), parseFloat($thisMin), parseFloat($thisMax)];		
      } else {
        $thisRange = _.range(parseFloat($thisMin), parseFloat($thisMax) + 1);	
      }

    $("#animals .fields").each(function(i){
      if ($(this).is(":visible") && $(this).find(".sppCommon").select2("val") == $thisSpecies && i != $index ) { 

        var $animal = $(this).find('.sppCommon').select2("val"); 
        var $number = $(this).find('[id$="number_individuals"]').val();
        var $mean = $(this).find('[id$="average_length"]').val();
        var $min = $(this).find('[id$="min_length"]').val();
        var $max = $(this).find('[id$="max_length"]').val();

        var $range
      if ( $number == 1 ){
        $range = [parseFloat($mean)];	
      } else if ( $number == 2 ) {
        $range = [parseFloat($min), parseFloat($max)];		
      } else if ( $number == 3 ) {
        $range = [parseFloat($mean), parseFloat($min), parseFloat($max)];		
      } else {
        $range = _.range(parseFloat($min), parseFloat($max) + 1);	
      }	

    spp[i] = { "species": $animal, "range": $range}; 
      };
    });

    var hasOverlap;
    if ( _.isEmpty(spp) ) { hasOverlap = false; }
    else {
      var checkBool = []
        for ( rec in spp ) { checkBool.push( _.intersection(spp[rec].range, $thisRange).length>0); };
      hasOverlap = _.contains( checkBool, true );
    }
    return hasOverlap == false;
    }, "record overlaps with other record"
    );



    $.validator.addMethod("isNotInPreviousTimePeriod",function(value, element, params) {

      var time_1_spp
      var time_2_spp
      var $thisSpecies = $(element).parent().find('.sppCommon').select2("val");
      var $this_spp_time_period = $(element).parent().find("[id$=time_seen]").val();


    function setSppInTimeSeenArrays() {
      var timeSeen_1_Array = new Array();
      var timeSeen_2_Array = new Array();
      $(".select2-container").each(function(){
        if ( $(this).is(":visible") ) {
          var $sppId = $(this).select2('val');
          var $timePeriod = $(this).parent().find('[id$="time_seen"]').val();
          if ($timePeriod == 1 && !_.contains(timeSeen_1_Array, $sppId)) {
            timeSeen_1_Array.push($sppId);
          } else if ( $timePeriod == 2 && !_.contains(timeSeen_2_Array, $sppId) ) {
            timeSeen_2_Array.push($sppId);
          }
        }
      });

      time_1_spp = timeSeen_1_Array  
      time_2_spp = timeSeen_2_Array  
    };

    if ( $this_spp_time_period == 1 ) { return true; }
    else if ( $this_spp_time_period == 2 ) {
      setSppInTimeSeenArrays();
      return !_.contains(time_1_spp, $thisSpecies); }
    else if ( $this_spp_time_period == 3 ){
      setSppInTimeSeenArrays();
      var previousTimeBool = [!_.contains(time_1_spp, $thisSpecies), !_.contains(time_2_spp, $thisSpecies)];
      return !_.contains(previousTimeBool, false); }
    }, "This species is in previous time period" 
    );


    $.validator.addMethod(
    "lessThan",
    function(value, element, params) {
      function meanIsEnabled(e) {
        //return e.parent().find('[id$="average_length"]').is(":enabled");
        return e.parent().find('[id$="number_individuals"]').val() >= 3;
      }
 
      if (meanIsEnabled($(element))) {
        return parseFloat(value) <= parseFloat($(element).parent().find('[id$="average_length"]').val());;
      }
 
      return true;
    },
    "must be less than or equal to average length"
  );
 
    $.validator.addMethod(
    "greaterThanEqualToAvg",
    function(value, element, params) {
      function avgIsEnabled(e) {
        //return e.parent().find('[id$="average_length"]').is(":enabled");
        return e.parent().find('[id$="number_individuals"]').val() >= 3;
      }

      if (avgIsEnabled($(element))) {
        return parseFloat(value) >= parseFloat($(element).parent().find('[id$="average_length"]').val());;
      }
 
      return true;
    },
    "must be greater than or equal to average length"
  );
 
    $.validator.addMethod(
    "greaterThanEqualToMin",
    function(value, element, params) {
      function minIsEnabled(e) {
        return e.parent().find('[id$="min_length"]').is(":enabled");
      }
 
      if (minIsEnabled($(element))) {
        return parseFloat(value) >= parseFloat($(element).parent().find('[id$="min_length"]').val());;
      }
 
      return true;
    },
    "must be greater than or equal to min length"
  );

   // modified from http://orip.org/2010/06/jquery-validate-required-if-visible.html 

    $.validator.addMethod(
    "requiredIfEnabled",
    function(value, element, params) {
      function isEnabled(e) {
        // the element and all of its parents must be :visible
        // inspiration: http://remysharp.com/2008/10/17/jquery-really-visible/
        return e.is(":enabled");
      }
 
      if (isEnabled($(element))) {
        // call the "required" method
        return $.validator.methods.required.call(this, $.trim(element.value), element);
      }
 
      return true;
    },
    $.validator.messages.required
  );

    $.validator.setDefaults ({
      errorPlacement: function (error, element) {
        if ( element.is('[id$="number_individuals"]') || element.is('[id$="average_length"]') || element.is('[id$="min_length"]') || element.is('[id$="max_length"]') ) {
          error.insertAfter(element.parent().find('[id$="max_length"]'));
          } else if ( element.is(".hard_relief") || element.is(".soft_relief") ) { 
          error.insertAfter(element.parent().parent().parent().parent());
          } else {
            error.insertAfter(element);
          }
        }
    });

    $(".new_sample, .edit_sample").validate({

      errorElement: "span",
      ignore: ".ignore",

      onfocusout: function(element) {
        this.element(element);
      },

        rules: {
                'sample[boatlog_manager_id]': {
                         required: true
                       },
                'sample[sample_date]': {
                         required: true
                       },
                'sample[sample_type_id]': {
                         required: true
                       },
                'sample[habitat_type_id]': {
                         required: true
                       },
                'sample[dive_begin_time]': {
                         required: true
                       },
                'sample[dive_end_time]': {
                         required: true,
                          greaterThan: '#sample_dive_begin_time'
                       },
                'sample[sample_begin_time]': {
                         required: true,
                         greaterThan: '#sample_dive_begin_time',
                         before: '#sample_dive_end_time'
                       },
                'sample[sample_end_time]': {
                         required: true,
                          greaterThan: '#sample_sample_begin_time',
                          before: '#sample_dive_end_time'
                       },
                'sample[field_id]': {
                         required: true,
                          fieldID: true,
                          minlength: 6,
                          maxlength: 6
                       },
                'sample[dive_depth]': {
                        required: true,
                        digits: true,
                        max: 200
                      },
                'sample[sample_depth]': {
                        required: true,
                        digits: true,
                        max: 200
                      },
                'sample[underwater_visibility]': {
                        required: true,
                        digits: true
                      },
                'sample[water_temp]': {
                        required: true,
                        digits: true
                      },
                'sample[sample_description]': {
                        maxlength: 150
                      },
                'sample[substrate_max_depth]': {
                        required: true,
                        digits: true
                      }
                    },
        messages: {
                'sample[dive_end_time]': {
                  greaterThan: "Dive end cannot be before dive begin"
                    },
                'sample[sample_begin_time]': {
                  greaterThan: "Sample begin cannot be before dive begin",
                  before: "Sample begin time cannot be after dive end time"
                    },
                'sample[sample_end_time]': {
                  greaterThan: "Sample end time cannot be before begin time",
                  before: "Sample end time cannot be after dive end time"
                }
                }
    });

    $('[name*="diver_id"]').each(function(){
      $(this).rules("add", { required: true });
    });
    
    function validate_fields() {
      $('[name*="number_individuals"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          isNotInPreviousTimePeriod: true
        });
      });
      $('[name*="average_length"]').each(function(){
        $(this).rules('add', {
          requiredIfEnabled: true,
          number: true,
          doesNotHaveOverlap: true
        });
      });
      $('[name*="min_length"]').each(function(){
        $(this).rules('add', {
          requiredIfEnabled: true,
          number: true,
          lessThan: true,
          doesNotHaveOverlap: true
        });
      });
      $('[name*="max_length"]').each(function(){
        $(this).rules('add', {
          requiredIfEnabled: true,
          number: true,
          greaterThanEqualToAvg: true,
          greaterThanEqualToMin: true,
          doesNotHaveOverlap: true
        });
      });
    };

    validate_fields();
    $(document).delegate(".add_nested_fields", "click", function(){ 
      validate_fields();
      $('.validateIcon').empty();
      $('#submitButton').attr('disabled', true);
    });

    $('#animals').change(function(){
        $('input.error').each(function(){
          $('form').validate().element(this);
        });
        $('.validateIcon').empty();
        $('#submitButton').attr('disabled', true);
    });

  
    //$('form').bind('change keyup', function() {
      //if ( $('#animals input:visible.error').length == 0 ) {
        //$('#submitButton').attr('disabled', false);
      //} else {
        //$('#submitButton').attr('disabled', true);
      //}
    //});



  speciesInformation = {}
  if ( typeof animal_info !== "undefined" ) {
    $.each(animal_info, function(a){
      speciesInformation[animal_info[a].id] = { "max_num": animal_info[a].max_number, "min_size": animal_info[a].min_size, "max_size": animal_info[a].max_size };
    });
  }

  function alertSpeciesSizes() {
    $('[id$="number_individuals"]').on('focusout', function(){
      var $species = $(this).parent().find('.sppCommon').select2('val');
      if ( $(this).val() > speciesInformation[$species].max_num) {
        alert("over max number");
      }; 
    });

    $('[id$="average_length"]').on('focusout', function(){
      var $species = $(this).parent().find('.sppCommon').select2('val');
      var $speciesNumber = $(this).parent().find('[id$="number_individuals"]').val();
      if ( $speciesNumber == 1 ) {
        if ( $(this).val() < speciesInformation[$species].min_size ) {
          alert("under min size");
        } else if ( $(this).val() > speciesInformation[$species].max_size ) {
          alert("over max size");
        };
      };
    });

    $('[id$="min_length"]').on('focusout', function(){
      var $species = $(this).parent().find('.sppCommon').select2('val');
      if ( $(this).val() < speciesInformation[$species].min_size) {
        alert("under min size");
      }; 
    });
    $('[id$="max_length"]').on('focusout', function(){
      var $species = $(this).parent().find('.sppCommon').select2('val');
      if ( $(this).val() > speciesInformation[$species].max_size) {
        alert("over max size");
      }; 
    });
  };
  
  alertSpeciesSizes();


  function alert24HourClock() {
    $("#sample_dive_begin_time, #sample_dive_end_time, #sample_sample_begin_time, #sample_sample_end_time, .boatlog_time").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 >= "700" && $time2 <= "1900" ){
      
      } else { alert("why are you diving in the dark?"); }
    });
  };

  alert24HourClock();
  $('#submitButton').attr('disabled', true);

});
