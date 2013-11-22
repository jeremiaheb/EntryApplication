


$(function(){ 
  
  $("#coral_demographic_sample_date").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  $("#coral_demographic_sample_begin_time").timeEntry({ show24Hours: true });

  $(".demo_corals").find(".coralSpecies").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".coralSpecies").select2();
  });

    //puts focus on the select_2 drop down after adding cover pressed
     $(document).delegate(".add_nested_fields", "click", function(){ 
        $(".demo_corals input:text:visible").eq(-6).focus();
   });

    //supress submitting form on pressing enter key, enter key adds new coral
    //while inside coverCat class
    
    $("#coralDemoData").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
      }
    });

    $(".demo_corals").bind("keypress", function(e){
      if (e.keyCode ==13){
        e.preventDefault();
        $(".add_nested_fields").trigger("click");
      }
    });


    $(".new_coral_demographic, .edit_coral_demographic").validate({

      errorElement: "span",


      onfocusout: function(element) {
        this.element(element);
      },

        rules: {
                'coral_demographic[boatlog_manager_id]': {
                         required: true
                       },
                'coral_demographic[diver_id]': {
                         required: true
                       },
                'coral_demographic[buddy]': {
                         required: true
                       },
                'coral_demographic[field_id]': {
                         required: true,
                          minlength: 5,
                          maxlength: 5
                       },
                'coral_demographic[sample_date]': {
                        required: true
                      },
                'coral_demographic[sample_begin_time]': {
                        required: true
                      },
                'coral_demographic[habitat_type_id]': {
                        required: true
                      },
                'coral_demographic[meters_completed]': {
                        required: true,
                        digits: true
                      },
                'coral_demographic[sample_description]': {
                        maxlength: 150
                      }


               },
        messages: {

                  }
    });

    function validate_fields() {
      $('[name*="max_diameter"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="perpendicular_diameter"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="height"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="old_mortality"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="recent_mortality"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true
        });
      });
      $('[name*="bleach_condition"]').each(function(){
        $(this).rules('add', {
          required: true
        });
      });

    };

    validate_fields();
    $(document).delegate(".add_nested_fields", "click", function(){ 
      validate_fields();
    });

});
