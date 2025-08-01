$(function () {
  if (!EA.onRailsPage("samples", ["edit", "new"])) {
    return;
  }

  $("#substrateSection").hide();
  $("#speciesSection").hide();
  $(".changeSection").change(function () {
    // hide
    $("div.sectionDiv").hide();
    // val is something like #div1 or #div2
    var targetId = $(this).val();
    // show the new selected one
    $("#" + targetId).show();
  });

  if ($("form").hasClass("new_sample")) {
    $(".changeSection option[value='substrateSection']").attr(
      "disabled",
      "disabled",
    );
    $(".changeSection option[value='speciesSection']").attr(
      "disabled",
      "disabled",
    );
  }

  function show_or_hide_substrate() {
    var should_display_substrate = new Array();
    var errorCount = $("#sampleSection :input.error").length;

    $("#sampleSection")
      .find(".tab_1")
      .each(function () {
        // This equality test does NOT work with '0' because they time
        // option_selects can be '0'
        if ($(this).val() == "") {
          should_display_substrate.push($(this));
        }
      });

    if (should_display_substrate.length == 0 && errorCount == 0) {
      $(".changeSection option[value='substrateSection']").removeAttr(
        "disabled",
      );
      $("#gotoSubstrate").attr("disabled", false);
    } else {
      $(".changeSection option[value='substrateSection']").attr(
        "disabled",
        true,
      );
      $("#gotoSubstrate").attr("disabled", true);
    }
  }

  function show_or_hide_species() {
    var should_display_species = new Array();
    var all_totals_equal_hundred = new Boolean();
    var errorCount = $("#substrateSection :input.error").length;

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

    $("#substrateSection")
      .find(".tab_2")
      .each(function () {
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
      $(".changeSection option[value='speciesSection']").removeAttr("disabled");
      $("#gotoSpecies").attr("disabled", false);
    } else {
      $(".changeSection option[value='speciesSection']").attr("disabled", true);
      $("#gotoSpecies").attr("disabled", true);
    }
  }

  $("#gotoSubstrate").click(function () {
    $("#sampleSection").hide();
    $("#substrateSection").show();
    $(".changeSection").val("substrateSection");
  });

  $("#gotoSpecies").click(function () {
    $("#substrateSection").hide();
    $("#speciesSection").show();
    $(".changeSection").val("speciesSection");
  });

  //Show or hide sections
  if ($("form").hasClass("new_sample")) {
    show_or_hide_substrate();
    show_or_hide_species();
  }

  //on change check if section should show
  $(".tab_1").focusout(function () {
    show_or_hide_substrate();
  });

  $("#substrateSection").focusout(function () {
    show_or_hide_species();
    $("#substrateSection")
      .find(
        ".hard_relief[disabled=disabled], .soft_relief[disabled=disabled], .biotic_percentage_sand[disabled=disabled] ",
      )
      .val("");
  });

  function disable_hard_surface_relief_coverage() {
    $(
      "#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
    ).attr("disabled", false);
    var $hardVertVal = $("#sample_hard_verticle_relief").val();

    if ($hardVertVal <= 0.2) {
      $(
        "#sample_hard_relief_cat_1, #sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
      ).attr("disabled", true);
    } else if ($hardVertVal > 0.2 && $hardVertVal <= 0.5) {
      $(
        "#sample_hard_relief_cat_2, #sample_hard_relief_cat_3, #sample_hard_relief_cat_4",
      ).attr("disabled", true);
    } else if ($hardVertVal > 0.5 && $hardVertVal <= 1.0) {
      $("#sample_hard_relief_cat_3, #sample_hard_relief_cat_4").attr(
        "disabled",
        true,
      );
    } else if ($hardVertVal > 1.0 && $hardVertVal <= 1.5) {
      $("#sample_hard_relief_cat_4").attr("disabled", true);
    } else {
    }
  }

  function disable_soft_surface_relief_coverage() {
    $(
      "#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
    ).attr("disabled", false);
    var $softVertVal = $("#sample_soft_verticle_relief").val();

    if ($softVertVal <= 0.2) {
      $(
        "#sample_soft_relief_cat_1, #sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
      ).attr("disabled", true);
    } else if ($softVertVal > 0.2 && $softVertVal <= 0.5) {
      $(
        "#sample_soft_relief_cat_2, #sample_soft_relief_cat_3, #sample_soft_relief_cat_4",
      ).attr("disabled", true);
    } else if ($softVertVal > 0.5 && $softVertVal <= 1.0) {
      $("#sample_soft_relief_cat_3, #sample_soft_relief_cat_4").attr(
        "disabled",
        true,
      );
    } else if ($softVertVal > 1.0 && $softVertVal <= 1.5) {
      $("#sample_soft_relief_cat_4").attr("disabled", true);
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
    $(".biotic_percentage_sand").attr("disabled", false);
    $("#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab").attr(
      "disabled",
      false,
    );
    var $bioticSandVal = $("#sample_sand_percentage").val();

    if ($bioticSandVal == "" || $bioticSandVal == 0) {
      $(".biotic_percentage_sand").val("").attr("disabled", true);
      $("#sample_sand_pcov_other1_lab, #sample_sand_pcov_other2_lab").attr(
        "disabled",
        true,
      );
      $("#biotic_percentage_sand_total").removeClass();
    }
  }

  function disable_biotic_perc_hard() {
    $(".biotic_percentage_hardbottom").attr("disabled", false);
    $("#sample_hard_pcov_other1_lab, #sample_hard_pcov_other2_lab").attr(
      "disabled",
      false,
    );
    var $bioticHardVal = $("#sample_hardbottom_percentage").val();

    if ($bioticHardVal == "" || $bioticHardVal == 0) {
      $(".biotic_percentage_hardbottom").val("").attr("disabled", true);
      $("#sample_hard_pcov_other1_lab, #sample_hard_pcov_other2_lab").attr(
        "disabled",
        true,
      );
      $("#biotic_percentage_hardbottom_total").removeClass();
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

    $(".section_2")
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
    $(this).addClass("active").siblings().removeClass("active");
  });

  function set_time_seen_field_on_focus() {
    $(".sppCommon").on("open", function () {
      var $thisID = $(this).attr("id").slice(0, -10);
      var $radioTimeSeenVal = $('.time_seen_button[class*="active"]').val();

      $("input#" + $thisID + "_time_seen").attr("value", $radioTimeSeenVal);
      $("input#" + $thisID + "_time_seen").trigger("change");
      $("input#" + $thisID + "_number_individuals").attr(
        "class",
        "timeSeen_" + $radioTimeSeenVal,
      );
      $("input#" + $thisID + "_average_length").attr(
        "class",
        "timeSeen_" + $radioTimeSeenVal,
      );
      $("input#" + $thisID + "_min_length").attr(
        "class",
        "timeSeen_" + $radioTimeSeenVal,
      );
      $("input#" + $thisID + "_max_length").attr(
        "class",
        "timeSeen_" + $radioTimeSeenVal,
      );
    });
  }

  set_time_seen_field_on_focus();

  $(document).delegate(".add_nested_fields", "click", function () {
    set_time_seen_field_on_focus();
    enable_disable_animals_fields();
    alertSpeciesSizes();
    //$(".section_3 input:text:visible").eq(-5).focus();
    $(".section_3 input:text:visible").eq(-5);
    $(".section_3 .sppCommon:visible").last().select2("open");
    $("#animals").scrollTop($("#animals")[0].scrollHeight);
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
          $("input#" + $mean).attr("disabled", false);
          $("input#" + $min).attr("disabled", false);
          $("input#" + $max).attr("disabled", false);
        } else if ($indValue == 1) {
          $("input#" + $mean).attr("disabled", false);
          $("input#" + $min).attr("disabled", true);
          $("input#" + $max).attr("disabled", true);
        } else if ($indValue == 2) {
          $("input#" + $mean).attr("disabled", true);
          $("input#" + $min).attr("disabled", false);
          $("input#" + $max).attr("disabled", false);
        }
      });
  }

  function enable_disable_animals_fields() {
    $("[id$=number_individuals]").on("focusout", function () {
      var $indValue = $(this).val();
      var $recordID = $(this).attr("id");
      var $mean = $recordID.replace("_number_individuals", "_average_length");
      var $min = $recordID.replace("_number_individuals", "_min_length");
      var $max = $recordID.replace("_number_individuals", "_max_length");

      if ($indValue >= 3) {
        $("input#" + $mean).attr("disabled", false);
        $("input#" + $min).attr("disabled", false);
        $("input#" + $max).attr("disabled", false);
        $("input#" + $mean).focus();
      } else if ($indValue == 1) {
        $("input#" + $mean).attr("disabled", false);
        $("input#" + $min).val("");
        $("input#" + $min).attr("disabled", true);
        $("input#" + $max).val("");
        $("input#" + $max).attr("disabled", true);
        $("input#" + $mean).focus();
      } else if ($indValue == 2) {
        $("input#" + $mean)
          .val("")
          .attr("disabled", true);
        $("input#" + $min).attr("disabled", false);
        $("input#" + $max).attr("disabled", false);
        $("input#" + $min).focus();
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
        $(".new_sample, .edit_sample").validate().element(this);
      });

    if ($("#animals").find("input:visible.error").length > 0) {
      $(".validateCross").show();
    } else {
      $(".validateCheck").show();
      $("#submitButton").attr("disabled", false);
    }
  });

  $("#submitButton").click(function (e) {
    e.preventDefault();
    $(this).attr("disabled", true);

    $(".new_sample, .edit_sample").validate().cancelSubmit = true;
    $(".formContainer :input").not(this).attr("disabled", false);
    $(".new_sample, .edit_sample").submit();
  });

  $("#animals").bind("keypress", function (e) {
    if (e.keyCode == 13) {
      e.preventDefault();
      $(".add_nested_fields").trigger("click");
    }
  });

  $("#sample_sample_date").datepicker({
    format: "yyyy-mm-dd",
    orientation: "bottom",
    autoclose: true,
  });

  $(
    "#sample_dive_begin_time, #sample_dive_end_time, #sample_sample_begin_time, #sample_sample_end_time",
  ).timepicker({
    timeFormat: "HH:mm",
    dropdown: false,
  });

  $.validator.addMethod(
    "fieldID",
    function (value, element) {
      return this.optional(element) || /^\d{5}[a-zA-Z]$/i.test(value);
    },
    "FieldID is wrong format",
  );

  $.validator.addMethod("greaterThan", function (value, element, params) {
    return value > $(params).val();
  });

  $.validator.addMethod("before", function (value, element, params) {
    return value < $(params).val();
  });

  $.validator.addMethod("lessThanEqualTo", function (value, element, params) {
    return Number(value) <= Number($(params).val());
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
    "lessThan",
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

  // modified from http://orip.org/2010/06/jquery-validate-required-if-visible.html

  $.validator.addMethod(
    "requiredIfEnabled",
    function (value, element, params) {
      function isEnabled(e) {
        // the element and all of its parents must be :visible
        // inspiration: http://remysharp.com/2008/10/17/jquery-really-visible/
        return e.is(":enabled");
      }

      if (isEnabled($(element))) {
        // call the "required" method
        return $.validator.methods.required.call(
          this,
          $.trim(element.value),
          element,
        );
      }

      return true;
    },
    $.validator.messages.required,
  );

  $.validator.setDefaults({
    errorPlacement: function (error, element) {
      if (
        element.is('[id$="number_individuals"]') ||
        element.is('[id$="average_length"]') ||
        element.is('[id$="min_length"]') ||
        element.is('[id$="max_length"]')
      ) {
        error.insertAfter(element.parent().find('[id$="max_length"]'));
      } else if (element.is(".hard_relief") || element.is(".soft_relief")) {
        error.insertAfter(element.parent().parent().parent().parent());
      } else {
        error.insertAfter(element);
      }
    },
  });

  $(".new_sample, .edit_sample").validate({
    errorElement: "span",
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
        greaterThan: "#sample_dive_begin_time",
      },
      "sample[sample_begin_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
        greaterThan: "#sample_dive_begin_time",
        before: "#sample_dive_end_time",
      },
      "sample[sample_end_time]": {
        required: true,
        pattern: /^(06|07|08|09|10|11|12|13|14|15|16|17|18|19|20):([0-9]{2})$/,
        greaterThan: "#sample_sample_begin_time",
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
        greaterThan: "Dive end cannot be before dive begin",
      },
      "sample[sample_begin_time]": {
        pattern: "Time must be between 06:00 and 20:00",
        greaterThan: "Sample begin cannot be before dive begin",
        before: "Sample begin time cannot be after dive end time",
      },
      "sample[sample_end_time]": {
        pattern: "Time must be between 06:00 and 20:00",
        greaterThan: "Sample end time cannot be before begin time",
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
        lessThan: true,
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
    $("#submitButton").attr("disabled", true);
  });

  $("#animals").change(function () {
    $("input.error").each(function () {
      $("form").validate().element(this);
    });
    $(".validateCross, .validateCheck").hide();
    $("#submitButton").attr("disabled", true);
  });

  //$('form').bind('change keyup', function() {
  //if ( $('#animals input:visible.error').length == 0 ) {
  //$('#submitButton').attr('disabled', false);
  //} else {
  //$('#submitButton').attr('disabled', true);
  //}
  //});

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

  $("#submitButton").attr("disabled", true);
});
