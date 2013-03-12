// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require dataTables/jquery.dataTables
//= require jquery_nested_form
//= require rails.validations
//= require rails.validations.nested_form
//= require select2
//= require_tree .
//




$(function(){
    
    $('tr[data-link]').click(function(){
      window.location = this.dataset.link
    });

    $('tr[data-link]').hover(
      function(){
        $(this).css("background", "yellow");
        $(this).css("cursor", "pointer");
      },
      function(){
        $(this).css("background", "");
      }
    );



    $("#substrateSection").hide();
    $("#speciesSection").hide();
    $(".changeSection").change(function() {
      // hide
      $("div.sectionDiv").hide();
      // val is something like #div1 or #div2
      var targetId = $(this).val();
      // show the new selected one
      $("#"+targetId).show();
  });
   
    //$(".changeSection option[value='substrateSection']").attr("disabled", "disabled");
    //$(".changeSection option[value='speciesSection']").attr("disabled", "disabled");
 
    function show_or_hide_substrate(){

      var should_display_substrate = new Array();

      $('#sampleSection').find('.tab_1').each(function(){
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ( $(this).val() == '' )
          {
            should_display_substrate.push( $(this) );
          };
      });

      if ( should_display_substrate.length == 0 )
        { 
          $(".changeSection option[value='substrateSection']").removeAttr("disabled");
        } else {
          $(".changeSection option[value='substrateSection']").attr("disabled", true);
        };
    };

    function show_or_hide_species(){

      var should_display_species = new Array();
      var all_totals_equal_hundred = new Boolean();

      if ( $("#sample_sand_percentage").val() == 0 && $("#hard_relief_total").val() == 100 && $("#soft_relief_total").val() == 100 && $("#biotic_percentage_hardbottom_total").val() == 100 && $("#abiotic_percentage_total").val() == 100 ){
        all_totals_equal_hundred = true;
      } else if ( $("#sample_sand_percentage").val() > 0 && $("#substrateSection .one_hundred_ok_flag").length == 5 ){
        all_totals_equal_hundred = true;
      } else {
        all_totals_equal_hundred = false;
      };
      
      $('#substrateSection').find('.tab_2').each(function(){
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ( $(this).val() == '' )
          {
            should_display_species.push( $(this) );
          };
      });

      if ( should_display_species.length == 0 && all_totals_equal_hundred == true)
        { 
          $(".changeSection option[value='speciesSection']").removeAttr("disabled");
        } else {
          $(".changeSection option[value='speciesSection']").attr("disabled", true);
        };
    };


    //Show or hide sections
     //show_or_hide_substrate();
     //show_or_hide_species();

    //on change check if section should show
     //$('.tab_1').change(function(){ 
        //show_or_hide_substrate();
    //});
     
     //$('#substrateSection').focusout(function(){ 
        //show_or_hide_species();
        //$("#substrateSection").find(".hard_relief[disabled=disabled], .soft_relief[disabled=disabled], .biotic_percentage_sand[disabled=disabled] ").val("");
    //});


  function disable_hard_surface_relief_coverage(){
    
    $('#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4').attr('disabled', false);
    var $hardVertVal = $('#sample_hard_verticle_relief').val();
      
        if ( $hardVertVal <= 0.2 ){
          $('#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4').attr('disabled', true); 
    }  else if ( $hardVertVal > 0.2 && $hardVertVal <= 0.5 ){
          $('#sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4').attr('disabled', true); 
    }  else if ( $hardVertVal > 0.5 && $hardVertVal <= 1.0 ){
          $('#sample_hard_relief_cat_3, #sample_hard_relief_cat_4').attr('disabled', true);
    }  else if ( $hardVertVal > 1.0 && $hardVertVal <= 1.5 ){
          $('#sample_hard_relief_cat_4').attr('disabled', true);
    }  else {
    }
  };
   
  function disable_soft_surface_relief_coverage(){
    
    $('#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4').attr('disabled', false);
    var $softVertVal = $('#sample_soft_verticle_relief').val();
      
        if ( $softVertVal <= 0.2 ){
          $('#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4').attr('disabled', true); 
    }  else if ( $softVertVal > 0.2 && $softVertVal <= 0.5 ){
          $('#sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4').attr('disabled', true); 
    }  else if ( $softVertVal > 0.5 && $softVertVal <= 1.0 ){
          $('#sample_soft_relief_cat_3, #sample_soft_relief_cat_4').attr('disabled', true);
    }  else if ( $softVertVal > 1.0 && $softVertVal <= 1.5 ){
          $('#sample_soft_relief_cat_4').attr('disabled', true);
    }  else {
    }
  };

  disable_hard_surface_relief_coverage();
  disable_soft_surface_relief_coverage();

  $('#sample_hard_verticle_relief').on('focusout', function(){
    disable_hard_surface_relief_coverage();
  });  
  
  $('#sample_soft_verticle_relief').on('focusout', function(){
    disable_soft_surface_relief_coverage();
  });  

  function disable_biotic_perc_sand(){

    $('.biotic_percentage_sand').attr('disabled', false);
    $('#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab').attr('disabled', false);
    var $bioticSandVal = $('#sample_sand_percentage').val();

    if ( $bioticSandVal == "" || $bioticSandVal == 0 ){
      $('.biotic_percentage_sand').val("").attr('disabled', true);
      $('#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab').attr('disabled', true);
    }
  };
  
  disable_biotic_perc_sand();

  $('#sample_sand_percentage').on('focusout', function(){
    disable_biotic_perc_sand();
  });

  


  

  function set_time_seen_field_on_focus(){
      $('.sppCommon').on('open', function(){
        var $thisID = $(this).attr('id').slice(0, -10);
        var $radioTimeSeenVal = $('input:radio[name=timeSeen]:checked').val();

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
        $(".section_3 input:text:visible").eq(-5).focus();
   });


  $("#animals").find(".sppCommon").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".sppCommon").select2();
  });

   //$('form').on('nested:fieldAdded', function(event) {
    //$(event.target).find(':input').enableClientSideValidations();
  //});


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
    })
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
    } else if ($indValue == 1) {
        $('input#' + $mean).attr('disabled', false)
        $('input#' + $min).val("")
        $('input#' + $min).attr('disabled', true)
        $('input#' + $max).val("")
        $('input#' + $max).attr('disabled', true)
    } else if ( $indValue == 2 ){
        $('input#' + $mean).val("").attr('disabled', true)
        $('input#' + $min).attr('disabled', false)
        $('input#' + $max).attr('disabled', false)
    }
    });
  };
  
  enable_disable_animals_fields_on_load();
  enable_disable_animals_fields();


  //$(".new_sample, .edit_sample").submit(function(){
    //$(".formContainer :input").attr('disabled', false);
    //return true;
  //});

  $("#submitButton").click(function() {
    $(".edit_sample").validate().cancelSubmit = true;
    $(".formContainer :input").attr('disabled', false);
    $(".edit_sample").validate().submit();

    return false;

  });


  function calculate_totals( input_class_to_sum, id_to_display_total){
  
        var sum_for_display_total = new Array();
  
        $('.section_2').find('.' + input_class_to_sum ).each(function(){
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


     


   // Calculate total for 'surface_hard' when page loads
    calculate_totals( 'hard_relief', 'hard_relief_total' );

    // Calculate total for 'surface_hard' on change
    $('#sample_hard_verticle_relief').change(function(){
        calculate_totals( 'hard_relief', 'hard_relief_total' );
    });
    $('.hard_relief').focusout(function(){
        calculate_totals( 'hard_relief', 'hard_relief_total' );
    });

    // Calculate total for 'surface_soft' when page loads
    calculate_totals('soft_relief', 'soft_relief_total' );

    // Calculate total for 'surface_soft' on change
    $('#sample_soft_verticle_relief').change(function(){
        calculate_totals( 'soft_relief', 'soft_relief_total' );
    });
    $('.soft_relief').focusout(function(){
        calculate_totals( 'soft_relief', 'soft_relief_total' );
    });
    
    // Calculate total for 'abiotic_footprint' when page loads
    calculate_totals('abiotic_percentage', 'abiotic_percentage_total' );

    // Calculate total for 'abiotic_footprint' on change
    $('.abiotic_percentage').change(function(){
        calculate_totals( 'abiotic_percentage', 'abiotic_percentage_total' );
    });

    // Calculate total for 'biotic_percentage_sand' when page loads
    calculate_totals('biotic_percentage_sand', 'biotic_percentage_sand_total' );

    // Calculate total for 'biotic_percentage_sand' on change
    $('.biotic_percentage_sand').change(function(){
        calculate_totals( 'biotic_percentage_sand', 'biotic_percentage_sand_total' );
    });

    // Calculate total for 'biotic_percentage_hardbottom' when page loads
    calculate_totals('biotic_percentage_hardbottom', 'biotic_percentage_hardbottom_total' );

    // Calculate total for 'biotic_percentage_hardbottom' on change
    $('.biotic_percentage_hardbottom').change(function(){
        calculate_totals( 'biotic_percentage_hardbottom', 'biotic_percentage_hardbottom_total' );
    });

    $("form").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
        $(".add_nested_fields").trigger("click");
      }
    });

    $("#sample_dive_begin_time").timeEntry({ show24Hours: true });
    $("#sample_dive_end_time").timeEntry({ show24Hours: true });
    $("#sample_sample_begin_time").timeEntry({ show24Hours: true });
    $("#sample_sample_end_time").timeEntry({ show24Hours: true });


    $.validator.addMethod("greaterThan", function(value, element, params){
      return value > $(params).val();
    });
 
    $.validator.addMethod(
    "lessThan",
    function(value, element, params) {
      function prevIsEnabled(e) {
        return e.prev().is(":enabled");
      }
 
      if (prevIsEnabled($(element))) {
        return parseFloat(value) <= parseFloat($(element).prev().val());;
      }
 
      return true;
    },
    "must be less than or equal to average length"
  );
 
    $.validator.addMethod(
    "greaterThanEqualToAvg",
    function(value, element, params) {
      function prevIsEnabled(e) {
        return e.prev().prev().is(":enabled");
      }
 
      if (prevIsEnabled($(element))) {
        return parseFloat(value) >= parseFloat($(element).prev().prev().val());;
      }
 
      return true;
    },
    "must be greater than or equal to average length"
  );
 
    $.validator.addMethod(
    "greaterThanEqualToMin",
    function(value, element, params) {
      function prevIsEnabled(e) {
        return e.prev().is(":enabled");
      }
 
      if (prevIsEnabled($(element))) {
        return parseFloat(value) >= parseFloat($(element).prev().val());;
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

    $(".new_sample, .edit_sample").validate({
      onfocusout: function(element) {
        this.element(element);
      },
        rules: {
                date: {
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
                         required: true
                       },
                'sample[sample_end_time]': {
                         required: true,
                          greaterThan: '#sample_sample_begin_time'
                       },
                'sample[field_id]': {
                         required: true,
                          fieldidFormat: true
                       },
                'sample[dive_depth]': {
                        required: true,
                        digits: true
                      },
                'sample[sample_depth]': {
                        required: true,
                        digits: true
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
                      },
                'sample[substrate_min_depth]': {
                        required: true,
                        digits: true
                      },
                'sample[hard_verticle_relief]': {
                        required: true,
                        number: true
                      },
                'sample[soft_verticle_relief]': {
                        required: true,
                        number: true
                      },
                'sample[hard_relief_cat_0]': {
                        required: true,
                        number: true,
                        min: 1
                      },
                'sample[hard_relief_cat_1]': {
                        required: function(element) {
                                    return $('#sample_hard_verticle_relief').val() > 0.2;
                                  },
                        number: true,
                        min: 1
                      },
                'sample[hard_relief_cat_2]': {
                        required: function(element) {
                                    return $('#sample_hard_verticle_relief').val() > 0.5;
                                  },
                        number: true,
                        min: 1
                      },
                'sample[hard_relief_cat_3]': {
                        required: function(element) {
                                    return $('#sample_hard_verticle_relief').val() > 1.0;
                                  },
                        number: true,
                        min: 1
                      },
                'sample[hard_relief_cat_4]': {
                        required: function(element) {
                                    return $('#sample_hard_verticle_relief').val() > 1.5;
                                  },
                        number: true,
                        min: 1
                      },
                'sample[soft_relief_cat_0]': {
                        required: true,
                        number: true
                      },
                'sample[soft_relief_cat_1]': {
                        required: function(element) {
                                    return $('#sample_soft_verticle_relief').val() > 0.2;
                                  },
                        number: true
                      },
                'sample[soft_relief_cat_2]': {
                        required: function(element) {
                                    return $('#sample_soft_verticle_relief').val() > 0.5;
                                  },
                        number: true
                      },
                'sample[soft_relief_cat_3]': {
                        required: function(element) {
                                    return $('#sample_soft_verticle_relief').val() > 1.0;
                                  },
                        number: true
                      },
                'sample[soft_relief_cat_4]': {
                        required: function(element) {
                                    return $('#sample_soft_verticle_relief').val() > 1.5;
                                  },
                        number: true
                      }   
               },
        messages: {
                'sample[dive_end_time]': {
                  greaterThan: "Dive end cannot be before dive begin"
                    },
                'sample[sample_end_time]': {
                  greaterThan: "Sample end time cannot be before begin time"
                },
                'sample[field_id]': {
                  fieldidFormat: "Format is invalid"
                }
                  }
    });

    $('[name*="diver_id"]').each(function(){
      $(this).rules("add", { required: true });
    });
    
    function validate_fields() {
    $('[name*="number_individuals"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="average_length"]').each(function(){
      $(this).rules('add', {
        requiredIfEnabled: true
      });
    });
    $('[name*="min_length"]').each(function(){
      $(this).rules('add', {
        requiredIfEnabled: true,
        number: true,
        lessThan: true
      });
    });
    $('[name*="max_length"]').each(function(){
      $(this).rules('add', {
        requiredIfEnabled: true,
        greaterThanEqualToAvg: true,
        greaterThanEqualToMin: true
      });
    });
    };


    validate_fields();
    $(document).delegate(".add_nested_fields", "click", function(){ 
      validate_fields();
    });
});

