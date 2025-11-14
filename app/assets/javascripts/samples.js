$(function () {
  if (!EA.onRailsPage("samples", ["edit", "new", "create", "update"])) {
    return;
  }

  const $sampleFormTabs = $(".sample-form .tabs").tabs({
    activate: function (e, ui) {
      // After tab switch, focus the first input element in the tab
      $(ui.newPanel).find(":input:enabled").first().focus();
    },
  });

  $(".go-to-substrate-button").on("click", function (e) {
    e.preventDefault();
    $sampleFormTabs.tabs("option", "active", 1);
  });
  $(".go-to-species-button").on("click", function (e) {
    e.preventDefault();
    $sampleFormTabs.tabs("option", "active", 2);
  });

  $.validator.addMethod(
    "doesNotHaveOverlap",
    function (value, element, params) {
      var spp = {};
      var $index = $(element).parent().parent().index();

      var container = $(element).closest("li");
      var $thisSpecies = container.find(".sppCommon").select2("val");

      //var $thisSpecies = $(element).parent().find('.sppCommon').select2("val");
      var $thisNumber = container.find('[id$="number_individuals"]').val();
      var $thisMean = container.find('[id$="average_length"]').val();
      var $thisMin = container.find('[id$="min_length"]').val();
      var $thisMax = container.find('[id$="max_length"]').val();

      var $thisRange;

      if ($thisNumber == 1) {
        $thisRange = [parseFloat($thisMean)];
      } else if ($thisNumber == 2) {
        $thisRange = [parseFloat($thisMin), parseFloat($thisMax)];
      } else if ($thisNumber == 3) {
        $thisRange = [
          parseFloat($thisMean),
          parseFloat($thisMin),
          parseFloat($thisMax),
        ];
      } else {
        $thisRange = _.range(parseFloat($thisMin), parseFloat($thisMax) + 1);
      }

      $("#animals .fields").each(function (i) {
        if (
          $(this).is(":visible") &&
          $(this).find(".sppCommon").select2("val") == $thisSpecies &&
          i != $index
        ) {
          var $animal = $(this).find(".sppCommon").select2("val");
          var $number = $(this).find('[id$="number_individuals"]').val();
          var $mean = $(this).find('[id$="average_length"]').val();
          var $min = $(this).find('[id$="min_length"]').val();
          var $max = $(this).find('[id$="max_length"]').val();

          var $range;
          if ($number == 1) {
            $range = [parseFloat($mean)];
          } else if ($number == 2) {
            $range = [parseFloat($min), parseFloat($max)];
          } else if ($number == 3) {
            $range = [parseFloat($mean), parseFloat($min), parseFloat($max)];
          } else {
            $range = _.range(parseFloat($min), parseFloat($max) + 1);
          }

          spp[i] = { species: $animal, range: $range };
        }
      });

      var hasOverlap;
      if (_.isEmpty(spp)) {
        hasOverlap = false;
      } else {
        var checkBool = [];
        for (rec in spp) {
          checkBool.push(_.intersection(spp[rec].range, $thisRange).length > 0);
        }
        hasOverlap = _.contains(checkBool, true);
      }
      return hasOverlap == false;
    },
    "record overlaps with other record",
  );

  $.validator.addMethod(
    "isNotInPreviousTimePeriod",
    function (value, element, params) {
      const $element = $(element);

      const $thisSppID = $element.parent().find(".sppCommon").select2("val");
      const $thisTimePeriod = $element.parent().find("[id$=time_seen]").val();

      const sameSpeciesInEarlierTimeSeens = $(
        ".sppCommon.select2-container:visible",
      ).filter(function () {
        const $this = $(this);
        const sppID = $this.select2("val");
        const timeSeen = $this.parent().find("[id$=time_seen]").val();

        return sppID === $thisSppID && timeSeen < $thisTimePeriod;
      });

      return sameSpeciesInEarlierTimeSeens.length === 0;
    },
    "This species is in previous time period",
  );

  $.validator.addMethod(
    "lessThanEqualToAvg",
    function (value, element, params) {
      function meanIsEnabled(e) {
        //return e.parent().find('[id$="average_length"]').is(":enabled");
        return e.parent().find('[id$="number_individuals"]').val() >= 3;
      }

      if (meanIsEnabled($(element))) {
        return (
          parseFloat(value) <=
          parseFloat($(element).parent().find('[id$="average_length"]').val())
        );
      }

      return true;
    },
    "must be less than or equal to average length",
  );

  $.validator.addMethod(
    "greaterThanEqualToAvg",
    function (value, element, params) {
      function avgIsEnabled(e) {
        //return e.parent().find('[id$="average_length"]').is(":enabled");
        return e.parent().find('[id$="number_individuals"]').val() >= 3;
      }

      if (avgIsEnabled($(element))) {
        return (
          parseFloat(value) >=
          parseFloat($(element).parent().find('[id$="average_length"]').val())
        );
      }

      return true;
    },
    "must be greater than or equal to average length",
  );

  $.validator.addMethod(
    "greaterThanEqualToMin",
    function (value, element, params) {
      function minIsEnabled(e) {
        return e.parent().find('[id$="min_length"]').is(":enabled");
      }

      if (minIsEnabled($(element))) {
        return (
          parseFloat(value) >=
          parseFloat($(element).parent().find('[id$="min_length"]').val())
        );
      }

      return true;
    },
    "must be greater than or equal to min length",
  );

  // Rules for dynamically added fields
  $.validator.addClassRules("number-individuals", {
    required: true,
    digits: true,
    isNotInPreviousTimePeriod: true,
  });
  $.validator.addClassRules("average-length", {
    requiredIfEnabled: true,
    digits: true,
    doesNotHaveOverlap: true,
  });
  $.validator.addClassRules("min-length", {
    requiredIfEnabled: true,
    digits: true,
    lessThanEqualToAvg: true,
    doesNotHaveOverlap: true,
  });
  $.validator.addClassRules("max-length", {
    requiredIfEnabled: true,
    digits: true,
    greaterThanEqualToAvg: true,
    greaterThanEqualToMin: true,
    doesNotHaveOverlap: true,
  });

  const validator = $(".sample-form").validate({
    errorElement: "div",
    errorPlacement: function ($error, $element) {
      if ($element.closest(".grid-col").length > 0) {
        $error.addClass(["margin-left-05", "display-inline-block"]);
      }

      $closestNestedFields = $element.closest(".fields");
      if ($closestNestedFields.length > 0) {
        $closestNestedFields.append($error);
      } else {
        $error.insertAfter($element);
      }
    },
    ignore: ".ignore",

    onfocusout: function (element) {
      this.element(element);
    },

    rules: {
      "sample[boatlog_manager_id]": {
        required: true,
      },
      "sample[sample_date]": {
        required: true,
      },
      "sample[diver_id]": {
        required: true,
      },
      "sample[buddy_id]": {
        required: true,
      },
      "sample[sample_type_id]": {
        required: true,
      },
      "sample[habitat_type_id]": {
        required: true,
      },
      "sample[dive_begin_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
      },
      "sample[dive_end_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
        after: "#sample_dive_begin_time",
      },
      "sample[sample_begin_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
        after: "#sample_dive_begin_time",
        before: "#sample_dive_end_time",
      },
      "sample[sample_end_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
        after: "#sample_sample_begin_time",
        before: "#sample_dive_end_time",
      },
      "sample[field_id]": {
        required: true,
        fieldID: true,
        minlength: 6,
        maxlength: 6,
      },
      "sample[dive_depth]": {
        required: true,
        digits: true,
        max: 200,
      },
      "sample[sample_depth]": {
        required: true,
        digits: true,
        max: 200,
      },
      "sample[underwater_visibility]": {
        required: true,
        digits: true,
      },
      "sample[water_temp]": {
        required: true,
        digits: true,
      },
      "sample[sample_description]": {
        maxlength: 150,
      },
      "sample[substrate_max_depth]": {
        required: true,
        digits: true,
        min: 1,
      },
      "sample[substrate_min_depth]": {
        required: true,
        digits: true,
        min: 1,
        lessThanEqualTo: "#sample_substrate_max_depth",
      },
      "sample[hard_verticle_relief]": {
        required: true,
        number: true,
      },
      "sample[soft_verticle_relief]": {
        required: true,
        number: true,
      },
      "sample[hard_relief_cat_0]": {
        required: true,
        number: true,
        min: 1,
      },
      "sample[hard_relief_cat_1]": {
        required: function (element) {
          return $("#sample_hard_verticle_relief").val() > 0.2;
        },
        number: true,
        min: 1,
      },
      "sample[hard_relief_cat_2]": {
        required: function (element) {
          return $("#sample_hard_verticle_relief").val() > 0.5;
        },
        number: true,
        min: 1,
      },
      "sample[hard_relief_cat_3]": {
        required: function (element) {
          return $("#sample_hard_verticle_relief").val() > 1.0;
        },
        number: true,
        min: 1,
      },
      "sample[hard_relief_cat_4]": {
        required: function (element) {
          return $("#sample_hard_verticle_relief").val() > 1.5;
        },
        number: true,
        min: 1,
      },
      "sample[soft_relief_cat_0]": {
        required: true,
        number: true,
      },
      "sample[soft_relief_cat_1]": {
        required: function (element) {
          return $("#sample_soft_verticle_relief").val() > 0.2;
        },
        number: true,
      },
      "sample[soft_relief_cat_2]": {
        required: function (element) {
          return $("#sample_soft_verticle_relief").val() > 0.5;
        },
        number: true,
      },
      "sample[soft_relief_cat_3]": {
        required: function (element) {
          return $("#sample_soft_verticle_relief").val() > 1.0;
        },
        number: true,
      },
      "sample[soft_relief_cat_4]": {
        required: function (element) {
          return $("#sample_soft_verticle_relief").val() > 1.5;
        },
        number: true,
      },
    },
    messages: {
      "sample[dive_begin_time]": {
        pattern: "Time must be between 06:00 and 20:00",
      },
      "sample[dive_end_time]": {
        pattern: "Time must be between 06:00 and 20:00",
        after: "Dive end cannot be before dive begin",
      },
      "sample[sample_begin_time]": {
        pattern: "Time must be between 06:00 and 20:00",
        after: "Sample begin cannot be before dive begin",
        before: "Sample begin time cannot be after dive end time",
      },
      "sample[sample_end_time]": {
        pattern: "Time must be between 06:00 and 20:00",
        after: "Sample end time cannot be before begin time",
        before: "Sample end time cannot be after dive end time",
      },
      "sample[substrate_min_depth]": {
        lessThanEqualTo: "must less than equal to max depth",
      },
    },
  });

  const enableSurfaceReliefCoverageFields = function (e) {
    // Hard substrate
    const maxHardSubstrate = $("#sample_hard_verticle_relief").val();

    const $sampleHardReliefCat1 = $("#sample_hard_relief_cat_1");
    if (maxHardSubstrate <= 0.2) {
      $sampleHardReliefCat1.val("").prop("disabled", true);
    } else {
      $sampleHardReliefCat1.prop("disabled", false);
    }
    validator.element($sampleHardReliefCat1);

    const $sampleHardReliefCat2 = $("#sample_hard_relief_cat_2");
    if (maxHardSubstrate <= 0.5) {
      $sampleHardReliefCat2.val("").prop("disabled", true);
    } else {
      $sampleHardReliefCat2.prop("disabled", false);
    }
    validator.element($sampleHardReliefCat2);

    const $sampleHardReliefCat3 = $("#sample_hard_relief_cat_3");
    if (maxHardSubstrate <= 1.0) {
      $sampleHardReliefCat3.val("").prop("disabled", true);
    } else {
      $sampleHardReliefCat3.prop("disabled", false);
    }
    validator.element($sampleHardReliefCat3);

    const $sampleHardReliefCat4 = $("#sample_hard_relief_cat_4");
    if (maxHardSubstrate <= 1.5) {
      $sampleHardReliefCat4.val("").prop("disabled", true);
    } else {
      $sampleHardReliefCat4.prop("disabled", false);
    }
    validator.element($sampleHardReliefCat4);

    // Soft substrate
    const maxSoftSubstrate = $("#sample_soft_verticle_relief").val();

    const $sampleSoftReliefCat1 = $("#sample_soft_relief_cat_1");
    if (maxSoftSubstrate <= 0.2) {
      $sampleSoftReliefCat1.val("").prop("disabled", true);
    } else {
      $sampleSoftReliefCat1.prop("disabled", false);
    }
    validator.element($sampleSoftReliefCat1);

    const $sampleSoftReliefCat2 = $("#sample_soft_relief_cat_2");
    if (maxSoftSubstrate <= 0.5) {
      $sampleSoftReliefCat2.val("").prop("disabled", true);
    } else {
      $sampleSoftReliefCat2.prop("disabled", false);
    }
    validator.element($sampleSoftReliefCat2);

    const $sampleSoftReliefCat3 = $("#sample_soft_relief_cat_3");
    if (maxSoftSubstrate <= 1.0) {
      $sampleSoftReliefCat3.val("").prop("disabled", true);
    } else {
      $sampleSoftReliefCat3.prop("disabled", false);
    }
    validator.element($sampleSoftReliefCat3);

    const $sampleSoftReliefCat4 = $("#sample_soft_relief_cat_4");
    if (maxSoftSubstrate <= 1.5) {
      $sampleSoftReliefCat4.val("").prop("disabled", true);
    } else {
      $sampleSoftReliefCat4.prop("disabled", false);
    }
    validator.element($sampleSoftReliefCat4);
  };
  $("#sample_hard_verticle_relief, #sample_soft_verticle_relief").on(
    "focusout",
    enableSurfaceReliefCoverageFields,
  );
  enableSurfaceReliefCoverageFields();

  const calculateSubstrateTotals = function (e) {
    // Hard relief
    let hardReliefTotal = $("input.hard_relief").sumValues();
    $("#hard_relief_total").val(hardReliefTotal).setTotalValidClass();

    // Soft relief
    let softReliefTotal = $("input.soft_relief").sumValues();
    $("#soft_relief_total").val(softReliefTotal).setTotalValidClass();

    // Abiotic footprint
    let abioticFootprintTotal = $("input.abiotic_percentage").sumValues();
    $("#abiotic_percentage_total")
      .val(abioticFootprintTotal)
      .setTotalValidClass();

    // Sand (if enabled)
    const $sandFields = $(
      ".biotic_percentage_sand, #sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab",
    );
    if ($("#sample_sand_percentage").val() > 0) {
      $sandFields.prop("disabled", false);

      let sandTotal = $("input.biotic_percentage_sand").sumValues();
      $("#biotic_percentage_sand_total").val(sandTotal).setTotalValidClass();
    } else {
      $sandFields.val("").prop("disabled", true);
      $("#biotic_percentage_sand_total").val("").setTotalValidClass();
    }

    // Hardbottom (if enabled)
    const $hardbottomFields = $(
      ".biotic_percentage_hardbottom, #sample_hard_pcov_other1_lab, #sample_hard_pcov_other2_lab",
    );
    if ($("#sample_hardbottom_percentage").val() > 0) {
      $hardbottomFields.prop("disabled", false);

      let hardbottomTotal = $("input.biotic_percentage_hardbottom").sumValues();
      $("#biotic_percentage_hardbottom_total")
        .val(hardbottomTotal)
        .setTotalValidClass();
    } else {
      $hardbottomFields.val("").prop("disabled", true);
      $("#biotic_percentage_hardbottom_total").val("").setTotalValidClass();
    }
  };
  $("#substrate-tab").on("focusout", calculateSubstrateTotals);
  calculateSubstrateTotals();

  const enableTabs = function () {
    // Enable substrate tab if no errors on sample tab
    let sampleTabFieldsWithErrors = $("#sample-tab :input.error");
    let sampleTabEmptyRequiredFields = $("#sample-tab :input[required]").filter(
      function () {
        return $(this).val() == "";
      },
    );

    if (
      sampleTabFieldsWithErrors.length === 0 &&
      sampleTabEmptyRequiredFields.length === 0
    ) {
      $sampleFormTabs.tabs("enable", "#substrate-tab");
      $(".go-to-substrate-button").prop("disabled", false);
    } else {
      $sampleFormTabs.tabs("disable", "#substrate-tab");
      $(".go-to-substrate-button").prop("disabled", true);
    }

    // Enable species tab if no errors on substrate tab
    let substrateTabFieldsWithErrors = $("#substrate-tab :input.error");
    let substrateTabEmptyRequiredFields = $(
      "#substrate-tab :input[required]",
    ).filter(function () {
      return $(this).val() == "";
    });
    let substrateTabAllSumsToOneHundred =
      $("#hard_relief_total").val() == 100 &&
      $("#soft_relief_total").val() == 100 &&
      $("#abiotic_percentage_total").val() == 100 &&
      ($("#sample_sand_percentage").val() == 0 ||
        $("#biotic_percentage_sand_total").val() == 100) &&
      ($("#sample_hardbottom_percentage").val() == 0 ||
        $("#biotic_percentage_hardbottom_total").val() == 100);

    if (
      substrateTabFieldsWithErrors.length === 0 &&
      substrateTabEmptyRequiredFields.length === 0 &&
      substrateTabAllSumsToOneHundred
    ) {
      $sampleFormTabs.tabs("enable", "#species-tab");
      $(".go-to-species-button").prop("disabled", false);
    } else {
      $sampleFormTabs.tabs("disable", "#species-tab");
      $(".go-to-species-button").prop("disabled", true);
    }
  };
  $(".sample-form").on("focusout", enableTabs);
  enableTabs();

  $(".time_seen_button").click(function () {
    // Add focus ring to active time seen
    const $this = $(this);
    $this.siblings().removeClass("usa-focus");
    $this.addClass("usa-focus");
  });

  // Set time seen hidden field and CSS class when species select is opened
  $("#animals").on("select2-open", ".sppCommon", function (e) {
    const $target = $(e.target);
    const thisID = $target.attr("id").slice(0, -10);
    const currentTimeSeenVal = $(".time_seen_button.usa-focus").val();

    $("input#" + thisID + "_time_seen").val(currentTimeSeenVal);
    $("input#" + thisID + "_time_seen").trigger("change");
    $("input#" + thisID + "_number_individuals")
      .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
      .addClass("timeSeen_" + currentTimeSeenVal);
    $("input#" + thisID + "_average_length")
      .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
      .addClass("timeSeen_" + currentTimeSeenVal);
    $("input#" + thisID + "_min_length")
      .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
      .addClass("timeSeen_" + currentTimeSeenVal);
    $("input#" + thisID + "_max_length")
      .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
      .addClass("timeSeen_" + currentTimeSeenVal);
  });

  // Open species select automatically after adding a new row
  $(".sample-form").on("nested:fieldAdded", function () {
    const $lastSpeciesSelect = $("#species-tab .sppCommon:visible").last();
    if ($lastSpeciesSelect.length > 0) {
      $lastSpeciesSelect[0].scrollIntoView(true);
      $lastSpeciesSelect.select2("open");
    }
  });

  const enableSpeciesFieldsForRow = function ($row) {
    const $numIndividualsField = $row.find("[id$='number_individuals']");
    if ($numIndividualsField.length == 0) {
      return;
    }

    var $indValue = $numIndividualsField.val();
    var $recordID = $numIndividualsField.attr("id");
    var $mean = $recordID.replace("_number_individuals", "_average_length");
    var $min = $recordID.replace("_number_individuals", "_min_length");
    var $max = $recordID.replace("_number_individuals", "_max_length");

    if ($indValue >= 3) {
      $("input#" + $mean).prop("disabled", false);
      $("input#" + $min).prop("disabled", false);
      $("input#" + $max).prop("disabled", false);
    } else if ($indValue == 1) {
      $("input#" + $mean).prop("disabled", false);
      $("input#" + $min)
        .val("")
        .prop("disabled", true);
      $("input#" + $max)
        .val("")
        .prop("disabled", true);
    } else if ($indValue == 2) {
      $("input#" + $mean)
        .val("")
        .prop("disabled", true);
      $("input#" + $min).prop("disabled", false);
      $("input#" + $max).prop("disabled", false);
    }
  };

  $("#animals .fields").each(function () {
    const $row = $(this);
    enableSpeciesFieldsForRow($row);
  });
  $("#animals").on("focusout", "[id$='number_individuals']", function (e) {
    const $target = $(e.target);
    const $row = $target.closest(".fields");

    enableSpeciesFieldsForRow($row);

    // If the next focus target is now disabled, focus the next enabled field
    const $relatedTarget = $(e.relatedTarget);
    if ($relatedTarget.is(":disabled")) {
      $target.nextAll(":input:enabled").first().focus();
    }
  });

  $("#animals").on("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      $(".add_nested_fields").trigger("click");
    }
  });

  const $sampleSampleDate = $("#sample_sample_date");
  $sampleSampleDate.datepicker({
    format: "yyyy-mm-dd",
    orientation: "bottom",
    autoclose: true,
  });
  if ($sampleSampleDate.val() === "") {
    // Default to today if not set
    $sampleSampleDate.datepicker("setDate", new Date());
  }

  $(
    "#sample_dive_begin_time, #sample_dive_end_time, #sample_sample_begin_time, #sample_sample_end_time",
  ).timepicker({
    timeFormat: "HH:mm",
    dropdown: false,
  });

  $("#animals").find(".sppCommon").select2();
  $("#animals").on("nested:fieldAdded", function (e) {
    e.field.find(".sppCommon").select2();
  });
  $("#animals").on("nested:fieldAdded nested:fieldRemoved", function (e) {
    // Force re-validation
    $(".validateCross, .validateCheck").hide();
    $("#submitButton").prop("disabled", true);
  });

  $("#animals").on("input change", function () {
    // Force re-check of any fields that are currently shown as errors
    $("#animals input.error").each(function () {
      validator.element(this);
    });

    // Force re-validation
    $(".validateCross, .validateCheck").hide();
    $("#submitButton").prop("disabled", true);
  });

  $("#validateAnimals").on("click", function () {
    $(".validateCross, .validateCheck").hide();

    $("#animals")
      .find("input:enabled")
      .each(function () {
        validator.element(this);
      });

    if ($("#animals").find("input:visible.error").length > 0) {
      $(".validateCross").show();
    } else {
      $(".validateCheck").show();
      $("#submitButton").prop("disabled", false);
    }
  });

  $("#submitButton").on("click", function (e) {
    e.preventDefault();
    const $this = $(this);

    $this.prop("disabled", true);

    validator.cancelSubmit = true;
    $(".sample-form :input").not($this).prop("disabled", false);
    $(".sample-form").submit();
  });

  let speciesInformation = {};
  if (typeof animal_info !== "undefined") {
    $.each(animal_info, function (a) {
      speciesInformation[animal_info[a].id] = {
        max_num: animal_info[a].max_number,
        min_size: animal_info[a].min_size,
        max_size: animal_info[a].max_size,
      };
    });
  }

  // Alert for anomalous looking data
  $("#animals").on(
    "change focusout",
    "[id$='number_individuals']",
    function (e) {
      const $target = $(e.target);
      const $row = $target.closest(".fields");

      if (e.type === "change") {
        $target.removeData("number-individuals-alerted");
      } else if (!$target.data("number-individuals-alerted")) {
        let species = $row.find(".sppCommon").select2("val");
        if ($target.val() > speciesInformation[species].max_num) {
          $target.data("number-individuals-alerted", true);
          alert("over max number");
        }
      }
    },
  );

  $("#animals").on("change focusout", "[id$='average_length']", function (e) {
    const $target = $(e.target);
    const $row = $target.closest(".fields");

    if (e.type === "change") {
      $target.removeData("average-length-alerted");
    } else if (!$target.data("average-length-alerted")) {
      let species = $row.find(".sppCommon").select2("val");
      let speciesNumber = $row.find("[id$='number_individuals']").val();
      if (speciesNumber == 1) {
        if ($target.val() < speciesInformation[species].min_size) {
          $target.data("average-length-alerted", true);
          alert("under min size");
        } else if ($target.val() > speciesInformation[species].max_size) {
          $target.data("average-length-alerted", true);
          alert("over max size");
        }
      }
    }
  });

  $("#animals").on("change focusout", "[id$='min_length']", function (e) {
    const $target = $(e.target);
    const $row = $target.closest(".fields");

    if (e.type === "change") {
      $target.removeData("min-length-alerted");
    } else if (!$target.data("min-length-alerted")) {
      let species = $row.find(".sppCommon").select2("val");
      if ($target.val() < speciesInformation[species].min_size) {
        $target.data("min-length-alerted", true);
        alert("under min size");
      }
    }
  });

  $("#animals").on("change focusout", "[id$='max_length']", function (e) {
    const $target = $(e.target);
    const $row = $target.closest(".fields");

    if (e.type === "change") {
      $target.removeData("max-length-alerted");
    } else if (!$target.data("max-length-alerted")) {
      let species = $row.find(".sppCommon").select2("val");
      if ($target.val() > speciesInformation[species].max_size) {
        $target.data("max-length-alerted", true);
        alert("over max size");
      }
    }
  });
});
