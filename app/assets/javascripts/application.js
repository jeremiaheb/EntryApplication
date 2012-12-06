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
//= require jquery_nested_form
//= require rails.validations
//= require_tree .
//

$(function(){
   
    $("#substrateSection").hide();
    $("#speciesSection").hide();
    $(".changeSection").change(function() {
    // hide
    $("div.sectionDiv").hide();
    // val is something like #div1 or #div2
    var targetId = $(this).val();
    
    console.log($(targetId).html());
    // show the new selected one
    $("#"+targetId).show();
  });
/*   
    $(".changeSection option[value='substrateSection']").remove();
    $(".changeSection option[value='speciesSection']").remove();
   
    function show_or_hide_section(){

      var should_display_div = new Array();

      $('#sampleSection').find('.tab_1').each(function(){
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ( $(this).val() == '' )
          {
            should_display_div.push( $(this) );
          };
      });

      if ( should_display_div.length == 0 )
        { 
          $(".changeSection").append('<option value="substrateSection">Substrate Section</option>');
        };
    };
 */ 

/*
  function display_code_or_common(){
    var sppVal = $('select.code').slice(-2).val();
    var commonVal = $('select.common').slice(-2).val();
    var radioVal = $('input:radio[name=displayType]:checked').val();
    if ( radioVal == '0'){
      $('select.code option[value="' + commonVal + '"]').slice(-2).attr('selected', 'selected');
      $(".section_3 .common").attr('disabled', 'true');
      $(".section_3 .common").hide();
      $(".section_3 .code").removeAttr('disabled');
      $(".section_3 .code").show();
    }; 
    if ( radioVal == '1'){
      $('select.common option[value="' + sppVal + '"]').slice(-2).attr('selected', 'selected');
      $(".section_3 .code").attr('disabled', 'true');
      $(".section_3 .code").hide();
      $(".section_3 .common").removeAttr('disabled');
      $(".section_3 .common").show();
    };

  };
*/

  function display_code_or_common(){
    var radioVal = $('input:radio[name=displayType]:checked').val();
    if ( radioVal == '0'){
      $('select.common').each(function(index){
        var $commonVal = $('select.common').slice(index).val();
        $('select.code option[value="' + $commonVal + '"]').slice(index).attr('selected', 'selected');
      });
      $(".section_3 .common").attr('disabled', 'true');
      $(".section_3 .common").hide();
      $(".section_3 .code").removeAttr('disabled');
      $(".section_3 .code").show();
    }; 
    if ( radioVal == '1'){
      $('select.code').each(function(index){
        var $codeVal = $('select.code').slice(index).val();
        $('select.common option[value="' + $codeVal + '"]').slice(index).attr('selected', 'selected');
      });
      $(".section_3 .code").attr('disabled', 'true');
      $(".section_3 .code").hide();
      $(".section_3 .common").removeAttr('disabled');
      $(".section_3 .common").show();
    };

  };
   // On radio button change display code or common name
     
     $('.radio_button').on("change", function(e){ 
        display_code_or_common();
    });
     
     $(document).delegate(".add_nested_fields", "click", function(e){ 
        display_code_or_common();
      $('select.code option[value=""]').slice(-2).attr('selected', 'selected');
      $('select.common option[value=""]').slice(-2).attr('selected', 'selected');

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

/*
   // Show or hide sections
    show_or_hide_section();
*/
   // on change check if section should show
     $('.tab_1').change(function(){ 
        show_or_hide_section();
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

