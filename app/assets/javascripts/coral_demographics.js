$(function () {
  if (!EA.onRailsPage("coral_demographics", ["edit", "new", "create", "update"])) {
    return;
  }

  const $coralDemographicSampleDate = $("#coral_demographic_sample_date");
  $coralDemographicSampleDate.datepicker({
    format: "yyyy-mm-dd",
    orientation: "bottom",
    autoclose: true,
  });
  if ($coralDemographicSampleDate.val() === "") {
    // Default to today if not set
    $coralDemographicSampleDate.datepicker("setDate", new Date());
  }

  $("#coral_demographic_sample_begin_time").timepicker({
    timeFormat: "HH:mm",
    dropdown: false,
  });

  $(".demo_corals").find(".coralSpecies").select2();
  $(document).on("nested:fieldAdded", function (event) {
    event.field.find(".coralSpecies").select2();
  });

  function disable_fields_if_no_coral() {
    $(".coralSpecies").on("focusout", function () {
      $coralCat = $(this).find("span").text();
      if ($coralCat == "NO CORA") {
        $(this).closest("li").find(".coralSpeciesData").attr("disabled", true);
      }
    });
  }

  function disable_fields_if_no_coral_on_load() {
    $(".coralSpecies").each(function () {
      $coralCat = $(this).find("span").text();
      if ($coralCat == "NO CORA") {
        $(this).closest("li").find(".coralSpeciesData").attr("disabled", true);
      }
    });
  }

  disable_fields_if_no_coral_on_load();
  disable_fields_if_no_coral();
  $(document).delegate(".add_nested_fields", "click", function () {
    disable_fields_if_no_coral();
  });

  //puts focus on the select_2 drop down after adding cover pressed
  $(document).delegate(".add_nested_fields", "click", function () {
    $(".demo_corals input:text:visible").eq(-7).focus();
    $(".demo_corals").scrollTop(1e10);
  });

  //supress submitting form on pressing enter key, enter key adds new coral
  //while inside coverCat class

  $("#coralDemoData").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
    }
  });

  $(".demo_corals").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      $(".add_nested_fields").trigger("click");
    }
  });

  $.validator.addMethod(
    "lessThanEqualToMaxDiameter",
    function (value, element, params) {
      return (
        parseFloat(value) <=
        parseFloat($(element).parent().find('[id$="max_diameter"]').val())
      );
    },
    "must be less than or equal to max diameter",
  );

  $.validator.addMethod(
    "notGreaterThan100",
    function (value, element, params) {
      return (
        Number(value) +
          Number($(element).parent().find('[id$="old_mortality"]').val()) <=
        100
      );
    },
    "Old Mortality and Recent Mortality connot be greater than 100",
  );

  $(".new_coral_demographic, .edit_coral_demographic").validate({
    errorElement: "span",

    onfocusout: function (element) {
      this.element(element);
    },

    rules: {
      "coral_demographic[boatlog_manager_id]": {
        required: true,
      },
      "coral_demographic[diver_id]": {
        required: true,
      },
      "coral_demographic[buddy]": {
        required: true,
      },
      "coral_demographic[field_id]": {
        required: true,
        fieldID: true,
        minlength: 6,
        maxlength: 6,
      },
      "coral_demographic[sample_date]": {
        required: true,
      },
      "coral_demographic[sample_begin_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
      },
      "coral_demographic[habitat_type_id]": {
        required: true,
      },
      "coral_demographic[meters_completed]": {
        required: true,
        digits: true,
      },
      "coral_demographic[percent_hardbottom]": {
        required: true,
        digits: true,
        range: [1, 100],
      },
      "coral_demographic[sample_description]": {
        maxlength: 150,
      },
    },
    messages: {
      "coral_demographic[sample_begin_time]": {
        pattern: "Time must be between 06:00 and 20:00",
      },
    },
  });

  function validate_fields() {
    $('[name*="meter_mark"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        min: 0,
      });
    });
    $('[name*="max_diameter"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        min: 1,
      });
    });
    $('[name*="perpendicular_diameter"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        min: 1,
        lessThanEqualToMaxDiameter: true,
      });
    });
    $('[name*="height"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        min: 1,
      });
    });
    $('[name*="old_mortality"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
      });
    });
    $('[name*="recent_mortality"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        notGreaterThan100: true,
      });
    });
    $('[name*="bleach_condition"]').each(function () {
      $(this).rules("add", {
        required: true,
      });
    });
    $('[name*="disease"]').each(function () {
      $(this).rules("add", {
        required: true,
      });
    });
  }

  validate_fields();
  $(document).delegate(".add_nested_fields", "click", function () {
    validate_fields();
  });
});
