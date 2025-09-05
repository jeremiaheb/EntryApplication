$(function () {
  if (!EA.onRailsPage("samples", ["edit", "new", "create", "update"])) {
    return;
  }

  const $sampleFormTabs = $(".sample-form .tabs").tabs({});

  $(".go-to-substrate-button").on("click", function (e) {
    e.preventDefault();
    $sampleFormTabs.tabs("option", "active", 1);
  });
  $(".go-to-species-button").on("click", function (e) {
    e.preventDefault();
    $sampleFormTabs.tabs("option", "active", 2);
  });

  function show_or_hide_substrate() {
    var should_display_substrate = new Array();
    var errorCount = $("#sample-tab :input.error").length;

    $("#sample-tab :required").each(function () {
      // This equality test does NOT work with '0' because they time
      // option_selects can be '0'
      if ($(this).val() == "") {
        should_display_substrate.push($(this));
      }
    });

    if (should_display_substrate.length == 0 && errorCount == 0) {
      $sampleFormTabs.tabs("enable", "#substrate-tab");
      $(".go-to-substrate-button").prop("disabled", false);
    } else {
      $sampleFormTabs.tabs("disable", "#substrate-tab");
      $(".go-to-substrate-button").prop("disabled", true);
    }
  }

  function show_or_hide_species() {
    var should_display_species = new Array();
    var all_totals_equal_hundred = new Boolean();
    var errorCount = $("#substrate-tab :input.error").length;

    if (
      $("#sample_sand_percentage").val() > 0 &&
      $("#sample_hardbottom_percentage").val() > 0 &&
      $("#hard_relief_total").val() == 100 &&
      $("#soft_relief_total").val() == 100 &&
      $("#biotic_percentage_hardbottom_total").val() == 100 &&
      $("#biotic_percentage_sand_total").val() == 100 &&
      $("#abiotic_percentage_total").val() == 100
    ) {
      all_totals_equal_hundred = true;
    } else if (
      $("#sample_sand_percentage").val() == 0 &&
      $("#sample_hardbottom_percentage").val() > 0 &&
      $("#hard_relief_total").val() == 100 &&
      $("#soft_relief_total").val() == 100 &&
      $("#biotic_percentage_hardbottom_total").val() == 100 &&
      $("#abiotic_percentage_total").val() == 100
    ) {
      all_totals_equal_hundred = true;
    } else if (
      $("#sample_sand_percentage").val() > 0 &&
      $("#sample_hardbottom_percentage").val() == 0 &&
      $("#hard_relief_total").val() == 100 &&
      $("#soft_relief_total").val() == 100 &&
      $("#biotic_percentage_sand_total").val() == 100 &&
      $("#abiotic_percentage_total").val() == 100
    ) {
      all_totals_equal_hundred = true;
    } else {
      all_totals_equal_hundred = false;
    }

    $("#substrate-tab :required").each(function () {
      // This equality test does NOT work with '0' because they time
      // option_selects can be '0'
      if ($(this).val() == "") {
        should_display_species.push($(this));
      }
    });

    if (
      should_display_species.length == 0 &&
      all_totals_equal_hundred == true &&
      errorCount == 0
    ) {
      $sampleFormTabs.tabs("enable", "#species-tab");
      $(".go-to-species-button").prop("disabled", false);
    } else {
      $sampleFormTabs.tabs("disable", "#species-tab");
      $(".go-to-species-button").prop("disabled", true);
    }
  }

  //Show or hide sections
  show_or_hide_substrate();
  show_or_hide_species();

  //on change check if section should show
  $("#sample-tab").focusout(function () {
    show_or_hide_substrate();
  });

  $("#substrate-tab").focusout(function () {
    show_or_hide_species();
    $("#substrate-tab")
      .find(
        ".hard_relief:disabled, .soft_relief:disabled, .biotic_percentage_sand:disabled",
      )
      .val("");
  });

  function disable_hard_surface_relief_coverage() {
    $(
      "#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
    ).prop("disabled", false);
    var $hardVertVal = $("#sample_hard_verticle_relief").val();

    if ($hardVertVal <= 0.2) {
      $(
        "#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
      ).prop("disabled", true);
    } else if ($hardVertVal > 0.2 && $hardVertVal <= 0.5) {
      $(
        "#sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
      ).prop("disabled", true);
    } else if ($hardVertVal > 0.5 && $hardVertVal <= 1.0) {
      $("#sample_hard_relief_cat_3, #sample_hard_relief_cat_4").prop(
        "disabled",
        true,
      );
    } else if ($hardVertVal > 1.0 && $hardVertVal <= 1.5) {
      $("#sample_hard_relief_cat_4").prop("disabled", true);
    } else {
    }
  }

  function disable_soft_surface_relief_coverage() {
    $(
      "#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
    ).prop("disabled", false);
    var $softVertVal = $("#sample_soft_verticle_relief").val();

    if ($softVertVal <= 0.2) {
      $(
        "#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
      ).prop("disabled", true);
    } else if ($softVertVal > 0.2 && $softVertVal <= 0.5) {
      $(
        "#sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
      ).prop("disabled", true);
    } else if ($softVertVal > 0.5 && $softVertVal <= 1.0) {
      $("#sample_soft_relief_cat_3, #sample_soft_relief_cat_4").prop(
        "disabled",
        true,
      );
    } else if ($softVertVal > 1.0 && $softVertVal <= 1.5) {
      $("#sample_soft_relief_cat_4").prop("disabled", true);
    } else {
    }
  }

  disable_hard_surface_relief_coverage();
  disable_soft_surface_relief_coverage();

  $("#sample_hard_verticle_relief").on("focusout", function () {
    disable_hard_surface_relief_coverage();
    show_or_hide_species();
  });

  $("#sample_soft_verticle_relief").on("focusout", function () {
    disable_soft_surface_relief_coverage();
    show_or_hide_species();
  });

  function disable_biotic_perc_sand() {
    $(".biotic_percentage_sand").prop("disabled", false);
    $("#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab").prop(
      "disabled",
      false,
    );
    var $bioticSandVal = $("#sample_sand_percentage").val();

    if ($bioticSandVal == "" || $bioticSandVal == 0) {
      $(".biotic_percentage_sand").val("").prop("disabled", true);
      $("#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab").prop(
        "disabled",
        true,
      );
      $("#biotic_percentage_sand_total").removeClass([
        "one_hundred_flag",
        "one_hundred_ok_flag",
      ]);
    }
  }

  function disable_biotic_perc_hard() {
    $(".biotic_percentage_hardbottom").prop("disabled", false);
    $("#sample_hard_pcov_other1_lab, #sample_hard_pcov_other2_lab").prop(
      "disabled",
      false,
    );
    var $bioticHardVal = $("#sample_hardbottom_percentage").val();

    if ($bioticHardVal == "" || $bioticHardVal == 0) {
      $(".biotic_percentage_hardbottom").val("").prop("disabled", true);
      $("#sample_hard_pcov_other1_lab, #sample_hard_pcov_other2_lab").prop(
        "disabled",
        true,
      );
      $("#biotic_percentage_hardbottom_total").removeClass([
        "one_hundred_flag",
        "one_hundred_ok_flag",
      ]);
    }
  }

  disable_biotic_perc_sand();
  disable_biotic_perc_hard();

  $("#sample_sand_percentage, #sample_hardbottom_percentage").on(
    "focusout",
    function () {
      disable_biotic_perc_sand();
      disable_biotic_perc_hard();
    },
  );

  function calculate_totals(input_class_to_sum, id_to_display_total) {
    var sum_for_display_total = new Array();

    $("#substrate-tab")
      .find("." + input_class_to_sum)
      .each(function () {
        if ($(this).val() != 0) {
          sum_for_display_total.push($(this).val());
        }
      });

    var total = 0;

    $.each(sum_for_display_total, function () {
      total += parseFloat(this);
    });

    // If total is gr)ater than 100 then flag it by add a red background.
    if (total != 100) {
      $("#" + id_to_display_total).removeClass("one_hundred_ok_flag");
      $("#" + id_to_display_total).addClass("one_hundred_flag");
    } else {
      $("#" + id_to_display_total).addClass("one_hundred_ok_flag");
      $("#" + id_to_display_total).removeClass("one_hundred_flag");
    }

    $("#" + id_to_display_total).val(total);
  }

  // Calculate total for 'surface_hard' when page loads
  calculate_totals("hard_relief", "hard_relief_total");

  // Calculate total for 'surface_hard' on change
  $("#sample_hard_verticle_relief").on("focusout", function () {
    calculate_totals("hard_relief", "hard_relief_total");
    $(".hard_relief").trigger("focusout");
  });
  $(".hard_relief").focusout(function () {
    calculate_totals("hard_relief", "hard_relief_total");
  });

  // Calculate total for 'surface_soft' when page loads
  calculate_totals("soft_relief", "soft_relief_total");

  // Calculate total for 'surface_soft' on change
  $("#sample_soft_verticle_relief").on("focusout", function () {
    calculate_totals("soft_relief", "soft_relief_total");
    $(".soft_relief").trigger("focusout");
  });
  $(".soft_relief").focusout(function () {
    calculate_totals("soft_relief", "soft_relief_total");
  });

  // Calculate total for 'abiotic_footprint' when page loads
  calculate_totals("abiotic_percentage", "abiotic_percentage_total");

  // Calculate total for 'abiotic_footprint' on change
  $(".abiotic_percentage").change(function () {
    calculate_totals("abiotic_percentage", "abiotic_percentage_total");
  });

  // Calculate total for 'biotic_percentage_sand' when page loads
  if ($("#sample_sand_percentage").val() != 0) {
    calculate_totals("biotic_percentage_sand", "biotic_percentage_sand_total");
  }

  // Calculate total for 'biotic_percentage_sand' on change
  $(".biotic_percentage_sand").change(function () {
    calculate_totals("biotic_percentage_sand", "biotic_percentage_sand_total");
  });

  // Calculate total for 'biotic_percentage_hardbottom' when page loads
  if ($("#sample_hardbottom_percentage").val() != 0) {
    calculate_totals(
      "biotic_percentage_hardbottom",
      "biotic_percentage_hardbottom_total",
    );
  }

  // Calculate total for 'biotic_percentage_hardbottom' on change
  $(".biotic_percentage_hardbottom").change(function () {
    calculate_totals(
      "biotic_percentage_hardbottom",
      "biotic_percentage_hardbottom_total",
    );
  });

  $(".time_seen_button").click(function () {
    $(this).addClass("usa-focus").siblings().removeClass("usa-focus");
  });

  function set_time_seen_field_on_focus() {
    $(".sppCommon").on("select2-open", function () {
      var $thisID = $(this).attr("id").slice(0, -10);
      var $radioTimeSeenVal = $(".time_seen_button.usa-focus").val();

      $("input#" + $thisID + "_time_seen").val($radioTimeSeenVal);
      $("input#" + $thisID + "_time_seen").trigger("change");
      $("input#" + $thisID + "_number_individuals")
        .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
        .addClass("timeSeen_" + $radioTimeSeenVal);
      $("input#" + $thisID + "_average_length")
        .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
        .addClass("timeSeen_" + $radioTimeSeenVal);
      $("input#" + $thisID + "_min_length")
        .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
        .addClass("timeSeen_" + $radioTimeSeenVal);
      $("input#" + $thisID + "_max_length")
        .removeClass(["timeSeen_1", "timeSeen_2", "timeSeen_3"])
        .addClass("timeSeen_" + $radioTimeSeenVal);
    });
  }

  set_time_seen_field_on_focus();

  $(document).delegate(".add_nested_fields", "click", function () {
    set_time_seen_field_on_focus();
    enable_disable_animals_fields();
    alertSpeciesSizes();

    const $lastSpeciesSelect = $("#species-tab .sppCommon:visible").last();
    $lastSpeciesSelect[0].scrollIntoView(true);
    $lastSpeciesSelect.select2("open");
  });

  $("#animals").find(".sppCommon").select2();
  $(document).on("nested:fieldAdded", function (event) {
    event.field.find(".sppCommon").select2();
  });

  function enable_disable_animals_fields_on_load() {
    $("#animals")
      .find(".fields [id$=number_individuals]")
      .each(function () {
        var $indValue = $(this).val();
        var $recordID = $(this).attr("id");
        var $mean = $recordID.replace("_number_individuals", "_average_length");
        var $min = $recordID.replace("_number_individuals", "_min_length");
        var $max = $recordID.replace("_number_individuals", "_max_length");

        if ($indValue >= 3) {
          $("input#" + $mean).prop("disabled", false);
          $("input#" + $min).prop("disabled", false);
          $("input#" + $max).prop("disabled", false);
        } else if ($indValue == 1) {
          $("input#" + $mean).prop("disabled", false);
          $("input#" + $min).prop("disabled", true);
          $("input#" + $max).prop("disabled", true);
        } else if ($indValue == 2) {
          $("input#" + $mean).prop("disabled", true);
          $("input#" + $min).prop("disabled", false);
          $("input#" + $max).prop("disabled", false);
        }
      });
  }

  function enable_disable_animals_fields() {
    $("[id$=number_individuals]").on("focusout", function (e) {
      var $indValue = $(this).val();
      var $recordID = $(this).attr("id");
      var $mean = $recordID.replace("_number_individuals", "_average_length");
      var $min = $recordID.replace("_number_individuals", "_min_length");
      var $max = $recordID.replace("_number_individuals", "_max_length");
      // $relatedTarget is the field that will be focused next
      var $relatedTarget = $(e.relatedTarget);

      if ($indValue >= 3) {
        $("input#" + $mean).prop("disabled", false);
        $("input#" + $min).prop("disabled", false);
        $("input#" + $max).prop("disabled", false);
        if ($relatedTarget.is(":disabled")) {
          $("input#" + $mean).focus();
        }
      } else if ($indValue == 1) {
        $("input#" + $mean).prop("disabled", false);
        $("input#" + $min).val("");
        $("input#" + $min).prop("disabled", true);
        $("input#" + $max).val("");
        $("input#" + $max).prop("disabled", true);
        if ($relatedTarget.is(":disabled")) {
          $("input#" + $mean).focus();
        }
      } else if ($indValue == 2) {
        $("input#" + $mean)
          .val("")
          .prop("disabled", true);
        $("input#" + $min).prop("disabled", false);
        $("input#" + $max).prop("disabled", false);
        if ($relatedTarget.is(":disabled")) {
          $("input#" + $min).focus();
        }
      }
    });
  }

  enable_disable_animals_fields_on_load();
  enable_disable_animals_fields();

  $("#validateAnimals").click(function () {
    $(".validateCross, .validateCheck").hide();

    $("#animals")
      .find("input:enabled")
      .each(function () {
        $(".new_sample, .edit_sample, .sample-form").validate().element(this);
      });

    if ($("#animals").find("input:visible.error").length > 0) {
      $(".validateCross").show();
    } else {
      $(".validateCheck").show();
      $("#submitButton").prop("disabled", false);
    }
  });

  $("#submitButton").click(function (e) {
    e.preventDefault();
    $(this).prop("disabled", true);

    $(".new_sample, .edit_sample, .sample-form").validate().cancelSubmit = true;
    $(".sample-form :input").not(this).prop("disabled", false);
    $(".new_sample, .edit_sample, .sample-form").submit();
  });

  $("#animals").bind("keypress", function (e) {
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

  // Check that a species record does not have overlapping sizes with another
  // record of the same species

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

  $(".new_sample, .edit_sample, .sample-form").validate({
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

  $('[name*="diver_id"]').each(function () {
    $(this).rules("add", { required: true });
  });

  function validate_fields() {
    $('[name*="number_individuals"]').each(function () {
      $(this).rules("add", {
        required: true,
        digits: true,
        isNotInPreviousTimePeriod: true,
      });
    });
    $('[name*="average_length"]').each(function () {
      $(this).rules("add", {
        requiredIfEnabled: true,
        digits: true,
        doesNotHaveOverlap: true,
      });
    });
    $('[name*="min_length"]').each(function () {
      $(this).rules("add", {
        requiredIfEnabled: true,
        digits: true,
        lessThanEqualToAvg: true,
        doesNotHaveOverlap: true,
      });
    });
    $('[name*="max_length"]').each(function () {
      $(this).rules("add", {
        requiredIfEnabled: true,
        digits: true,
        greaterThanEqualToAvg: true,
        greaterThanEqualToMin: true,
        doesNotHaveOverlap: true,
      });
    });
  }

  validate_fields();
  $(document).delegate(".add_nested_fields", "click", function () {
    validate_fields();
    $(".validateCross, .validateCheck").hide();
    $("#submitButton").prop("disabled", true);
  });

  $("#animals").change(function () {
    $("input.error").each(function () {
      $("form").validate().element(this);
    });
    $(".validateCross, .validateCheck").hide();
    $("#submitButton").prop("disabled", true);
  });

  speciesInformation = {};
  if (typeof animal_info !== "undefined") {
    $.each(animal_info, function (a) {
      speciesInformation[animal_info[a].id] = {
        max_num: animal_info[a].max_number,
        min_size: animal_info[a].min_size,
        max_size: animal_info[a].max_size,
      };
    });
  }

  function alertSpeciesSizes() {
    $('[id$="number_individuals"]').on("focusout", function () {
      var $species = $(this).parent().find(".sppCommon").select2("val");
      if ($(this).val() > speciesInformation[$species].max_num) {
        alert("over max number");
      }
    });

    $('[id$="average_length"]').on("focusout", function () {
      var $species = $(this).parent().find(".sppCommon").select2("val");
      var $speciesNumber = $(this)
        .parent()
        .find('[id$="number_individuals"]')
        .val();
      if ($speciesNumber == 1) {
        if ($(this).val() < speciesInformation[$species].min_size) {
          alert("under min size");
        } else if ($(this).val() > speciesInformation[$species].max_size) {
          alert("over max size");
        }
      }
    });

    $('[id$="min_length"]').on("focusout", function () {
      var $species = $(this).parent().find(".sppCommon").select2("val");
      if ($(this).val() < speciesInformation[$species].min_size) {
        alert("under min size");
      }
    });
    $('[id$="max_length"]').on("focusout", function () {
      var $species = $(this).parent().find(".sppCommon").select2("val");
      if ($(this).val() > speciesInformation[$species].max_size) {
        alert("over max size");
      }
    });
  }

  alertSpeciesSizes();
});
