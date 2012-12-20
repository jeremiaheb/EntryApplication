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
//= require dataTables/jquery.dataTables
//= require jquery_nested_form
//= require rails.validations
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
   
    $(".changeSection option[value='substrateSection']").attr("disabled", "disabled");
    $(".changeSection option[value='speciesSection']").attr("disabled", "disabled");
 
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

      if ( $("#sample_sand_percentage").val() == 0 && $("#substrateSection .one_hundred_ok_flag").length == 4 ){
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
      $('.biotic_percentage_sand').attr('disabled', true);
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
   });


  $("#speciesSection").find(".sppCommon").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".sppCommon").select2();
  });
  

  function calculate_totals( input_class_to_sum, id_to_display_total){
  
        var sum_for_display_total = new Array();
  
        $('.section_2').find('.' + input_class_to_sum).each(function(){
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


   // Show or hide sections
     show_or_hide_substrate();
     show_or_hide_species();

   // on change check if section should show
     $('.tab_1').change(function(){ 
        show_or_hide_substrate();
    });
     
     $('#substrateSection').on("focusout", function(){ 
        show_or_hide_species();
        $("#substrateSection").find(".hard_relief[disabled=disabled], .biotic_percentage_sand[disabled=disabled] ").val("");
    });

     


   // Calculate total for 'surface_hard' when page loads
    calculate_totals( 'hard_relief', 'hard_relief_total' );

    // Calculate total for 'surface_hard' on change
    $('.hard_relief').change(function(){
        calculate_totals( 'hard_relief', 'hard_relief_total' );
    });

    // Calculate total for 'surface_soft' when page loads
    calculate_totals('soft_relief', 'soft_relief_total' );

    // Calculate total for 'surface_soft' on change
    $('.soft_relief').change(function(){
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

});

