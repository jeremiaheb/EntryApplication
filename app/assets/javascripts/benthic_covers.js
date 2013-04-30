//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
//#
//#

$(function(){
 
  
  $("#benthic_cover_sample_date").dateEntry({dateFormat: "ymd-"});
  $("#benthic_cover_sample_begin_time").timeEntry({ show24Hours: true });

  $(".coverCats").find(".coverCategory").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".coverCategory").select2();
  });
  
    function getCoverTotals() {
      var $coverTotals = 0;

      $('.coverCats').find('.coverPoints:visible').each(function(){
        if ( $(this).val() != "" ) {  
        $coverTotals += parseFloat($(this).val());
        }
      });
      console.log($coverTotals);
      $('.coverTotal').text(" Total Points " + $coverTotals)
    };  

    getCoverTotals();
    $('.coverCats').change(function(){
      getCoverTotals();
    });

     $(document).delegate(".remove_nested_fields", "click", function(){ 
      getCoverTotals();
     });


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

    $("form").validate({

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
                          minlength: 5,
                          maxlength: 5
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
                'benthic_cover[invert_belts_attributes][0][lobster_num]': {
                        required: true
                      },
                'benthic_cover[invert_belts_attributes][0][conch_num]': {
                        required: true
                      },
                'benthic_cover[invert_belts_attributes][0][diadema_num]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][a_palmata]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][a_cervicornis]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][d_cylindrus]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][m_ferox]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][a_lamarcki]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][m_annularis]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][m_franksi]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][m_faveolata]': {
                        required: true
                      },
                'benthic_cover[presence_belts_attributes][0][d_stokesii]': {
                        required: true
                      }

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
