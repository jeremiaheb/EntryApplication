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
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  if ( $('body').hasClass('new') ) {
    $("#benthic_cover_sample_date").datepicker("setDate", new Date());
  };

  $("#benthic_cover_sample_begin_time").timeEntry({ show24Hours: true, minTime: "07:00", maxTime: "19:00" }); 

  $(".coverCats").find(".coverCategory").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".coverCategory").select2();
  });


    function getRugosityTotals() {
      var $rugosityTotals = 0;
        $(".rugosityCategories").find(".RugosityCat").each(function(){
          $rugosityTotals += parseInt($(this).val());
        });
        console.log($rugosityTotals);
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
                        digits: true
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
                'benthic_cover[rugosity_measure_attributes][max_vert_height]': {
                        required: true,
                        number: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_less_than_20]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_20_less_than_50]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_50_less_than_100]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_100_less_than_150]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_150_less_than_200]': {
                        required: true,
                        digits: true
                      },
                'benthic_cover[rugosity_measure_attributes][cnt_greater_than_200]': {
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
          number: true,
          isOnlyCat: true
        });
      });
      $('[name*="softbottom_num"]').each(function(){
        $(this).rules('add', {
          number: true
        });
      });
      $('[name*="rubble_num"]').each(function(){
        $(this).rules('add', {
          number: true
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
