


$(function(){ 
  
  if(!EA.onRailsPage('coral_demographics', ['edit', 'new'])) {
    return;
  }



  $("#coral_demographic_sample_date").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });

  if ( $('body').hasClass('new') ) {
    $("#coral_demographic_sample_date").datepicker("setDate", new Date());
  };

  $("#coral_demographic_sample_begin_time").timeEntry({ show24Hours: true });

  $(".demo_corals").find(".coralSpecies").select2(); 
  $(document).on('nested:fieldAdded', function(event){
    event.field.find(".coralSpecies").select2();
  });

  function disable_fields_if_no_coral() {
    $(".coralSpecies").on('focusout', function(){
      $coralCat = $(this).find('span').text();
      if ( $coralCat == "NO CORA" ) {
        $(this).closest("li").find(".coralSpeciesData").attr('disabled', true);
      }
    });
  }

  function disable_fields_if_no_coral_on_load() {
    $(".coralSpecies").each(function(){
      $coralCat = $(this).find('span').text();
      if ( $coralCat == "NO CORA" ) {
        $(this).closest("li").find(".coralSpeciesData").attr('disabled', true);
      }
    }); 
  };

  disable_fields_if_no_coral_on_load();
  disable_fields_if_no_coral();
  $(document).delegate(".add_nested_fields", "click", function(){ 
    disable_fields_if_no_coral();    
  });

    //puts focus on the select_2 drop down after adding cover pressed
     $(document).delegate(".add_nested_fields", "click", function(){ 
        $(".demo_corals input:text:visible").eq(-7).focus();
        $(".demo_corals").scrollTop(1E10);
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


    $.validator.addMethod("fieldID",function(value,element){
      return this.optional(element) || /^\d{5}[a-zA-Z]$/i.test(value); 
      },"FieldID is wrong format"
    );

    $.validator.addMethod("lessThan", function(value, element, params) {
    
        return parseFloat(value) <= parseFloat($(element).parent().find('[id$="max_diameter"]').val());;
 
    },
    "must be less than or equal to max diameter"
  );


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
                          fieldID: true,
                          minlength: 6,
                          maxlength: 6
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
                'coral_demographic[percent_hardbottom]': {
                        required: true,
                        digits: true,
                        range: [1,100]
                      },
                'coral_demographic[sample_description]': {
                        maxlength: 150
                      }


               },
        messages: {

                  }
    });

    function validate_fields() {
      $('[name*="meter_mark"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          min: 0
        });
      });
      $('[name*="max_diameter"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          min: 1
        });
      });
      $('[name*="perpendicular_diameter"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          min: 1,
          lessThan: true
        });
      });
      $('[name*="height"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          min: 1
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
      $('[name*="disease"]').each(function(){
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
