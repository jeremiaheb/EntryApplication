$(function () {
  if (!EA.onRailsPage("benthic_covers", ["edit", "new", "update", "create"])) {
    return;
  }

  $.validator.addMethod(
    "isOnlyCat",
    function (value, element, params) {
      const $element = $(element);
      if (!$element.is(":visible")) {
        return true;
      }

      const thisCategory = $element
        .parent()
        .find(".coverCategory")
        .select2("val");
      const categoriesWithThisCategory = $(
        ".coverCats .coverCategory.select2-container:visible",
      ).filter(function () {
        return $(this).select2("val") == thisCategory;
      });

      return categoriesWithThisCategory.length <= 1;
    },
    "Only one entry per cover Category",
  );

  // Rules for dynamically added fields
  $.validator.addClassRules("hardbottom-num-field", {
    digits: true,
    isOnlyCat: true,
  });
  $.validator.addClassRules("softbottom-num-field", {
    digits: true,
  });
  $.validator.addClassRules("rubble-num-field", {
    digits: true,
  });

  const validator = $(".benthic-cover-form").validate({
    errorElement: "div",
    errorPlacement: function ($error, $element) {
      if ($element.closest(".coverCats").length > 0) {
        // Place the error under the row
        $element.closest(".fields").append($error);
        return;
      }

      // Default
      $error.insertAfter($element);
    },

    onfocusout: function (element) {
      this.element(element);
    },

    rules: {
      "benthic_cover[boatlog_manager_id]": {
        required: true,
      },
      "benthic_cover[diver_id]": {
        required: true,
      },
      "benthic_cover[buddy_id]": {
        required: true,
      },
      "benthic_cover[field_id]": {
        required: true,
        fieldID: true,
        minlength: 6,
        maxlength: 6,
      },
      "benthic_cover[sample_date]": {
        required: true,
      },
      "benthic_cover[sample_begin_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
      },
      "benthic_cover[habitat_type_id]": {
        required: true,
      },
      "benthic_cover[meters_completed]": {
        required: true,
        digits: true,
        max: 15,
      },
      "benthic_cover[sample_description]": {
        maxlength: 150,
      },
      "benthic_cover[invert_belt_attributes][lobster_num]": {
        required: true,
        digits: true,
      },
      "benthic_cover[invert_belt_attributes][conch_num]": {
        required: true,
        digits: true,
      },
      "benthic_cover[invert_belt_attributes][diadema_num]": {
        required: true,
        digits: true,
      },
      "benthic_cover[presence_belt_attributes][a_palmata]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][a_cervicornis]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][d_cylindrus]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][m_ferox]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][m_annularis]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][m_franksi]": {
        required: true,
      },
      "benthic_cover[presence_belt_attributes][m_faveolata]": {
        required: true,
      },
      "benthic_cover[rugosity_measure_attributes][min_depth]": {
        required: true,
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][max_depth]": {
        required: true,
        digits: true,
        greaterThanEqualTo:
          "#benthic_cover_rugosity_measure_attributes_min_depth",
      },
      "benthic_cover[rugosity_measure_attributes][rug_meters_completed]": {
        required: true,
        digits: true,
        max: 15,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_1]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 1
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_2]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 2
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_3]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 3
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_4]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 4
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_5]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 5
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_6]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 6
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_7]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 7
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_8]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 8
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_9]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 9
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_10]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 10
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_11]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 11
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_12]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 12
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_13]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 13
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_14]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 14
          );
        },
        digits: true,
      },
      "benthic_cover[rugosity_measure_attributes][meter_mark_15]": {
        required: function (element) {
          return (
            $(
              "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
            ).val() >= 15
          );
        },
        digits: true,
      },
    },
    messages: {
      "benthic_cover[sample_begin_time]": {
        pattern: "Time must be between 06:00 and 20:00",
      },
      "benthic_cover[rugosity_measure_attributes][max_depth]": {
        greaterThanEqualTo: "must be greater than or equal to min depth",
      },
    },
  });

  const $benthicCoverSampleDate = $("#benthic_cover_sample_date");
  $benthicCoverSampleDate.datepicker({
    format: "yyyy-mm-dd",
    orientation: "bottom",
    autoclose: true,
  });
  if ($benthicCoverSampleDate.val() === "") {
    // Default to today if not set
    $benthicCoverSampleDate.datepicker("setDate", new Date());
  }

  $("#benthic_cover_sample_begin_time").timepicker({
    timeFormat: "HH:mm",
    dropdown: false,
  });

  $(".coverCats").find(".coverCategory").select2();
  $(".benthic-cover-form").on("nested:fieldAdded", function (event) {
    event.field.find(".coverCategory").select2();
  });

  const disableRugosityMeterMarks = function () {
    let metersCompleted = parseInt(
      $(
        "#benthic_cover_rugosity_measure_attributes_rug_meters_completed",
      ).val(),
    );

    $(".RugosityCat").each(function (index) {
      const $this = $(this);

      let value = index + 1;
      if (value > metersCompleted) {
        $this.val("").prop("disabled", true);
        validator.element($this);
      } else {
        $this.prop("disabled", false);
      }
    });
  };
  disableRugosityMeterMarks();
  $("#benthic_cover_rugosity_measure_attributes_rug_meters_completed").on(
    "focusout",
    disableRugosityMeterMarks,
  );

  const calculateRugosityTotal = function () {
    let rugosityTotal = $(".RugosityCat").sumValues();
    $("#RugosityTotalDisplay").val(rugosityTotal);
  };
  calculateRugosityTotal();
  $("#benthic_cover_rugosity_measure_attributes_rug_meters_completed").on(
    "focusout",
    calculateRugosityTotal,
  );
  $(".RugosityCat").on("change", calculateRugosityTotal);

  const updateCoverTotalText = function () {
    let coverTotal = $(".coverCats .coverPoints:visible").sumValues();

    $(".coverTotal").text("Total Points: " + coverTotal);
    if (coverTotal == 100) {
      $(".coverTotal")
        .removeClass("bg-secondary-light")
        .addClass("bg-primary-light");
    } else {
      $(".coverTotal")
        .addClass("bg-secondary-light")
        .removeClass("bg-primary-light");
    }
  };
  updateCoverTotalText();
  $(".coverCats").on("change", updateCoverTotalText);
  $(".benthic-cover-form").on(
    "nested:fieldAdded nested:fieldRemoved",
    updateCoverTotalText,
  );

  // Focus on the select2 drop down after adding cover pressed
  $(".benthic-cover-form").on("nested:fieldAdded", function () {
    const $lastCoverSelect = $(".coverCats .coverCategory:visible").last();
    if ($lastCoverSelect.length > 0) {
      $lastCoverSelect[0].scrollIntoView();
      $lastCoverSelect.select2("open");
    }
  });

  // supress submitting form on pressing enter key, enter key adds new cover cat
  // while inside coverCat class
  $("#benthicCoverData").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
    }
  });
  $(".coverCats").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      $(".add_nested_fields").trigger("click");
    }
  });

  $("#lpiSubmit").click(function (e) {
    e.preventDefault();
    const $this = $(this);

    validator.cancelSubmit = true;

    $(".benthic-cover-form")
      .find("input:enabled, select:enabled")
      .each(function () {
        validator.element(this);
      });

    let errorCount = $(".benthic-cover-form").find(
      "input:visible.error, select:visible.error",
    ).length;
    if (errorCount == 0) {
      let coverTotal = $(".coverCats .coverPoints:visible").sumValues();
      if (
        coverTotal != 100 &&
        !confirm(
          "Confirm: You are submitting fewer than 100 points. Please confirm you want to proceed.",
        )
      ) {
        return;
      }

      $(".benthic-cover-form :input").not($this).prop("disabled", false);
      $this.prop("disabled", true);
      $(".benthic-cover-form").submit();
    }
  });

  $("#benthic_cover_meters_completed").on("focusout", function (e) {
    let $this = $(this);
    let meters = Number($this.val());

    if (meters != 15) {
      alert("Caution: Full survey (15m) not entered");
    }
  });

  $(".benthic-cover-form").on(
    "nested:fieldAdded nested:fieldRemoved",
    function () {
      // Force re-check of any fields that are currently shown as errors
      $("input.error").each(function () {
        validator.element(this);
      });
    },
  );

  $(".coverCats").on("change", function () {
    // Force re-check of any fields that are currently shown as errors
    $("input.error").each(function () {
      validator.element(this);
    });
  });
});
