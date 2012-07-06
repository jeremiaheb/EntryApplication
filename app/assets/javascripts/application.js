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
//= require_tree .
//

$(function(){
    $("#substrateSection").hide();
    $("#speciesSection").hide();
    $(".changeSection").change(function() {
    // hide all brands first
    $("div.sectionDiv").hide();
    // val is something like #div1 or #div2
    var targetId = $(this).val();
    
    console.log($(targetId).html());
    // show the new selected one
    $("#"+targetId).show();
  });
  
    // Hide section two until section one is completely filled out
    /*$(".section_2").hide();

    function show_or_hide_section(){

      var should_display_div = new Array();

      $('.section_1').find('.tab_1').each(function(){
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ( $(this).val() == '' )
          {
            should_display_div.push( $(this) );
          };
      });

      if ( should_display_div.length == 0 )
        { 
          $(".section_2").show();
        };
    };*/
  


  function calculate_surface_relief( input_class_to_sum, id_to_display_total){
  
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

    /*// Check to see if section should be shown or hidden when page loads
    show_or_hide_section();

    // Onchange check to see if all values have been filled out. If so, then show the next div.
    $('.tab_1').change(function(){ 
        show_or_hide_section();
    });*/


   // Calculate total for 'surface_hard' when page loads
    calculate_surface_relief( 'hard_relief', 'hard_relief_total' );

    // Calculate total for 'surface_hard' on change
    $('.hard_relief').change(function(){
        calculate_surface_relief( 'hard_relief', 'hard_relief_total' );
    });

    // Calculate total for 'surface_soft' when page loads
    calculate_surface_relief('soft_relief', 'soft_relief_total' );

    // Calculate total for 'surface_soft' on change
    $('.soft_relief').change(function(){
        calculate_surface_relief( 'soft_relief', 'soft_relief_total' );
    });

});

