$(function () {
  if (
    !EA.onRailsPage("coral_demographics", ["edit", "new", "create", "update"])
  ) {
    return;
  }

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
    "Old Mortality and Recent Mortality cannot be greater than 100",
  );

  // Rules for dynamically added fields
  $.validator.addClassRules("meter-mark-field", {
    required: true,
    digits: true,
    min: 0,
  });
  $.validator.addClassRules("max-diameter-field", {
    required: true,
    digits: true,
    min: 1,
  });
  $.validator.addClassRules("perpendicular-diameter-field", {
    required: true,
    digits: true,
    min: 1,
    lessThanEqualToMaxDiameter: true,
  });
  $.validator.addClassRules("height-field", {
    required: true,
    digits: true,
    min: 1,
  });
  $.validator.addClassRules("old-mortality-field", {
    required: true,
    digits: true,
  });
  $.validator.addClassRules("recent-mortality-field", {
    required: true,
    digits: true,
    notGreaterThan100: true,
  });
  $.validator.addClassRules("bleach-condition-field", {
    required: true,
  });
  $.validator.addClassRules("disease-field", {
    required: true,
  });

  const validator = $(".coral-demographic-form").validate({
    errorElement: "div",
    errorPlacement: function ($error, $element) {
      let $demoCoralWrapper = $element.closest(".demo_corals .fields");
      if ($demoCoralWrapper.length > 0) {
        // Place the error under the row
        $demoCoralWrapper.append($error);
        return;
      }

      // Default
      $error.insertAfter($element);
    },

    onfocusout: function (element) {
      this.element(element);
    },

    rules: {
      "coral_demographic[mission_id]": {
        required: true,
      },
      "coral_demographic[diver_id]": {
        required: true,
      },
      "coral_demographic[buddy_id]": {
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
  $(".coral-demographic-form").on("nested:fieldAdded", function (event) {
    event.field.find(".coralSpecies").select2();
  });

  // Focus on the meter mark after adding cover pressed
  $(".coral-demographic-form").on("nested:fieldAdded", function () {
    const $lastMeterMarkInput = $(
      ".demo_corals .meter-mark-field:visible",
    ).last();
    if ($lastMeterMarkInput.length > 0) {
      $lastMeterMarkInput[0].scrollIntoView();
      $lastMeterMarkInput.focus();
    }
  });

  // supress submitting form on pressing enter key, enter key adds new coral while inside demo_corals class
  $(".coral-demographic-form").bind("keypress", function (e) {
    const $target = $(e.target);
    if (e.keyCode == 13 && !$target.is(":button") && !$target.is(":submit")) {
      e.preventDefault();
    }
  });
  $(".demo_corals").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      $(".add_nested_fields").trigger("click");
    }
  });

  $("#submitButton").on("click", function (e) {
    e.preventDefault();
    const $this = $(this);

    validator.cancelSubmit = true;

    $(".coral-demographic-form")
      .find("input:enabled, select:enabled")
      .each(function () {
        validator.element(this);
      });

    let errorCount = $(".coral-demographic-form").find(
      "input:visible.error, select:visible.error",
    ).length;
    if (errorCount == 0) {
      $(".coral-demographic-form :input").not($this).prop("disabled", false);
      $this.prop("disabled", true);
      $(".coral-demographic-form").submit();
    }
  });
});
