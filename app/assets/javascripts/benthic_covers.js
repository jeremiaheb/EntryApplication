//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//#
//#



$(function(){
 
  if(!EA.onRailsPage('benthic_covers', ['edit', 'new'])) {
    return;
  }
  
  $("#benthic_cover_sample_date").datepicker({
    dateFormat: 'yy-mm-dd',
  });

  $("#benthic_cover_sample_begin_time").timeEntry({ show24Hours: true, minTime: "06:00", maxTime: "20:00" }); 

  $(".coverCats").find(".coverCategory").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".coverCategory").select2();
  });


    function disable_rugosity_meter_marks (){
      var $rugIndexLess = $('#benthic_cover_rugosity_measure_attributes_rug_meters_completed').val();
        
        $('.RugosityCat').each(function(index, el){
            
            var value = index + 1;

	          if (value > parseInt($rugIndexLess)) { 
              $(el).val("").removeClass("error").attr("disabled", true);
              $(el).siblings("span").remove();
            } else  { $(el).attr("disabled", false); }
           }
        );
    };
  
    disable_rugosity_meter_marks();

  $('#benthic_cover_rugosity_measure_attributes_rug_meters_completed').on('focusout', function(){
    disable_rugosity_meter_marks();
  });  
    


    function getRugosityTotals() {
      var $rugosityTotals = 0;
        $(".rugosityCategories").find(".RugosityCat").each(function(){
          $rugosityTotals += parseInt($(this).val());
        });
      $("#RugosityTotalDisplay").val($rugosityTotals);
    };

    getRugosityTotals();
    $('.RugosityCat').change(function(){
      getRugosityTotals();
    });
  
    function getCoverTotals() {
      var $coverTotals = 0;

      $('.coverCats').find('.coverPoints:visible').each(function(){
        if ( $(this).val() != "" ) {  
        $coverTotals += parseFloat($(this).val());
        }
      });
      $('.coverTotal').text(" Total Points " + $coverTotals)
    };  

    getCoverTotals();
    $('.coverCats').change(function(){
      getCoverTotals();
    });

     $(document).delegate(".remove_nested_fields", "click", function(){ 
      getCoverTotals();
     });

    //puts focus on the select_2 drop down after adding cover pressed
     $(document).delegate(".add_nested_fields", "click", function(){ 
        $(".cover_data input:text:visible").eq(-4).focus();
   });

    //supress submitting form on pressing enter key, enter key adds new cover
    //cat while inside coverCat class
    
    $("#benthicCoverData").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
      }
    });
  
    $(".coverCats").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
        $(".add_nested_fields").trigger("click");
      }
    });
  
  
  $("#lpiSubmit").click(function(e) {
    e.preventDefault();

    
    $(".new_benthic_cover, .edit_benthic_cover").validate().cancelSubmit = true;
    
    $('.benthic_covers').find('input:enabled').each(function(){
      $('.new_benthic_cover, .edit_benthic_cover').validate().element(this);
    });

    var $errors = $(".benthic_covers").find('input:visible.error').length + $(".benthic_covers").find('select:visible.error').length;

    if ($errors == 0 ) {
      $(".formContainer :input").not(this).attr('disabled', false);
      $(".new_benthic_cover, .edit_benthic_cover").submit();
    }

  });


      $.validator.addMethod("fieldID",function(value,element){
        return this.optional(element) || /^\d{5}[a-zA-Z]$/i.test(value); 
        },"FieldID is wrong format"
      );

    $.validator.addMethod("isOnlyCat", function(value, element, params){
      var $catList = []
      var $thisCat = $(element).parent().find(".coverCategory").select2('val');
      var $index = $(element).parent().parent().index();

      	$(".coverCats .fields").each(function(i){
          if ( $(this).is(":visible") ) {
            var $category = $(this).find('.coverCategory').select2("val");          
          $catList.push( $category );
          }

          
        });

        console.log($catList);
        var $uniqCatList = _.uniq($catList);
        return $catList.length == $uniqCatList.length

    }, "Only one entry per cover Category"
    );

    $(".new_benthic_cover, .edit_benthic_cover").validate({

      errorElement: "span",


      onfocusout: function(element) {
        this.element(element);
      },

        rules: {
                'benthic_cover[boatlog_manager_id]': {
                         required: true
                       },
                'benthic_cover[diver_id]': {
                         required: true
                       },
                'benthic_cover[buddy]': {
                         required: true
                       },
                'benthic_cover[field_id]': {
                          required: true,
                          fieldID: true,
                          minlength: 6,
                          maxlength: 6
                       },
                'benthic_cover[sample_date]': {
                        required: true
                      },
                'benthic_cover[sample_begin_time]': {
                        required: true
                      },
                'benthic_cover[habitat_type_id]': {
                        required: true
                      },
                'benthic_cover[meters_completed]': {
                        required: true,
                        digits: true,
                        max: 15
                      },
                'benthic_cover[sample_description]': {
                        maxlength: 150
                      },
                'benthic_cover[invert_belt_attributes][lobster_num]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[invert_belt_attributes][conch_num]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[invert_belt_attributes][diadema_num]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[presence_belt_attributes][a_palmata]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][a_cervicornis]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][d_cylindrus]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][m_ferox]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][m_annularis]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][m_franksi]': {
                        required: true
                      },
                'benthic_cover[presence_belt_attributes][m_faveolata]': {
                        required: true
                      },
                'benthic_cover[rugosity_measure_attributes][min_depth]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][max_depth]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][rug_meters_completed]': {
                        required: true,
                        digits: true,
                        max: 15
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_1]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_2]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_3]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_4]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_5]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_6]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_7]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_8]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_9]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_10]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_11]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_12]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_13]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_14]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][meter_mark_15]': {
                        required: true,
                        digits: true
                      },

               },
        messages: {
                  }
    });

    function validate_fields() {
      $('[name*="hardbottom_num"]').each(function(){
        $(this).rules('add', {
          digits: true,
          isOnlyCat: true
        });
      });
      $('[name*="softbottom_num"]').each(function(){
        $(this).rules('add', {
          digits: true
        });
      });
      $('[name*="rubble_num"]').each(function(){
        $(this).rules('add', {
          digits: true
        });
      });

    };

    validate_fields();
    $(document).delegate(".add_nested_fields", "click", function(){ 
      validate_fields();
    });

    $('.coverCats').change(function(){
        $('input.error').each(function(){
          $('form').validate().element(this);
        });
    });

});
