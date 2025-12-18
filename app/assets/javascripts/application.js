// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery/dist/jquery
//= require jquery-ujs/src/rails
//= require datatables.net/js/dataTables
//= require datatables.net-dt/js/dataTables.dataTables
//= require select2
//= require jquery-validation/dist/jquery.validate
//= require jquery-validation/dist/additional-methods
//= require js/bootstrap
//= require jquery_nested_form
//= require underscore/underscore-umd
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker
//= require jquery-timepicker/jquery.timepicker
//= require plotly.js-dist-min/plotly.min.js
//= require jquery-ui/widgets/sortable
//= require jquery-ui/widgets/tabs
//= require jquery-ui/widgets/dialog
//= require jspreadsheet-ce/dist/index
//= require jsuites/dist/jsuites
//
//= require ./jquery_extensions
//= require ./validations
//= require ./benthic_covers
//= require ./boat_logs
//= require ./coral_demographics
//= require ./samples
//= require ./missions
//= require ./cleanups
//= require ./drafts
//= require_self

// Set up our EA namespace for our functions
var EA = {};
EA.onRailsPage = function (railsController, railsActions) {
  var selector = _.map(railsActions, function (action) {
    return "body." + railsController + "." + action;
  }).join(", ");

  return $(selector).length > 0;
};

$(function () {
  const $trLinks = $("tr[data-link]");

  $trLinks.on("click", function (e) {
    const $this = $(this);
    const $target = $(e.target);

    // If the user actually clicked on an <a> within the <tr>, let the default
    // behavior prevail. The user may have, e.g., ctrl-clicked on it to open it
    // in a new tab or window, and we do not want to interfere with that
    // behavior.
    if ($target.is("a[href]")) {
      return;
    }

    window.location.href = $this.attr("data-link");
  });

  $trLinks.hover(
    function () {
      $(this).css("background", "yellow");
      $(this).css("cursor", "pointer");
    },
    function () {
      $(this).css("background", "");
    },
  );

  $(".display").DataTable({
    layout: {
      topStart: "search",
      topEnd: ["info", "paging"],
      bottomStart: null,
      bottomEnd: ["info", "paging"],
    },
    pagingType: "full",
    columnDefs: [
      { targets: ".not-orderable", orderable: false },
      { targets: ".not-searchable", searchable: false },
      // Default (must be last in the list)
      { targets: "_all", type: "text" },
    ],
  });

  $("form").attr("autocomplete", "off");

  $("select").keypress(function (event) {
    return cancelBackspace(event);
  });
  $("select").keydown(function (event) {
    return cancelBackspace(event);
  });

  function cancelBackspace(event) {
    if (event.keyCode == 8) {
      return false;
    }
  }

  const addFocusClassToLabel = function () {
    const $focused = $(document.activeElement);
    const focusedID = $focused.attr("id");

    $("label.focused").removeClass("focused");
    if (focusedID) {
      $("label[for='" + focusedID + "']").addClass("focused");
    }
  };

  addFocusClassToLabel();
  $(document).on("focusin focusout", ":input", addFocusClassToLabel);

  // Dynamically update mission-select based on region-select (restrict
  // mission-select only to those missions that are valid in a given region).
  const missionSelectOptions = $(".mission-select").find("option");
  const updateMissionSelectForRegion = function () {
    const $missionSelect = $(".mission-select");
    const $regionSelect = $(".region-select");
    const regionID = Number($regionSelect.val());

    // The first option is the blank/placeholder option and always visible
    let $lastVisibleOption = $(missionSelectOptions[0]);
    for (let i = 1; i < missionSelectOptions.length; i++) {
      const $option = $(missionSelectOptions[i]);

      const regionIDForOption = Number($option.data("region-id"));
      if (regionIDForOption === regionID) {
        if ($option.prop("detached")) {
          $option.removeProp("detached");
          $option.insertAfter($lastVisibleOption);
        }

        $lastVisibleOption = $option;
      } else {
        if ($option.is(":selected")) {
          $missionSelect.val("");
        }

        if (!$option.prop("detached")) {
          $option.removeAttr("selected");
          $option.prop("detached", true);
          $option.detach();
        }
      }
    }
  };

  $(".region-select").on("change", updateMissionSelectForRegion);
  updateMissionSelectForRegion();

  $("#region_ids").select2();
  $("#agency_ids").select2();
  $("#project_ids").select2();

  // Dynamically update habitat-type-select based on region-select (restrict
  // habitat-type-select only to those that are valid in a given region).
  const updateHabitatTypeSelectForRegion = function () {
    const $habitatTypeSelect = $(".habitat-type-select");
    const $regionSelect = $(".region-select");
    const regionID = Number($regionSelect.val());

    // Disable any habitat types not valid for the given region
    $habitatTypeSelect.find("option").each(function (idx, option) {
      const $option = $(option);

      const regionIDs = $option.data("region-ids");
      if (!regionIDs) {
        return;
      }

      $option.prop("disabled", !regionIDs.includes(regionID));
    });

    // Force a re-selection if the previously selected habitat type is no
    // longer valid in the given region.
    if ($habitatTypeSelect.find("option:selected").is(":disabled")) {
      $habitatTypeSelect.val("");
    }
  };

  $(".region-select").on("change", updateHabitatTypeSelectForRegion);
  updateHabitatTypeSelectForRegion();
});
