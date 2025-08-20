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
//
//= require ./validations
//= require ./benthic_covers
//= require ./boat_logs
//= require ./coral_demographics
//= require ./missions
//= require ./samples
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
  $("tr[data-link]").click(function () {
    window.location = this.dataset.link;
  });

  $("tr[data-link]").hover(
    function () {
      $(this).css("background", "yellow");
      $(this).css("cursor", "pointer");
    },
    function () {
      $(this).css("background", "");
    },
  );

  $(document).ready(function () {
    const dataTable = $(".display").DataTable({
      layout: {
        topStart: "search",
        topEnd: ["info", "paging"],
        bottomStart: null,
        bottomEnd: ["info", "paging"],
      },
      pagingType: "full",
    });

    $("#region_ids")
      .select2()
      .on("change", function (e) {
        const regionIDs = $(this).val();
        dataTable.search.fixed("region", function(str, rowData, dataIndex) {
          const $row = $(dataTable.row(dataIndex).node());
          return regionIDs.includes($row.attr("data-region-id"));
        }).draw();
    });

    $("#agency_ids")
      .select2()
      .on("change", function (e) {
        const agencyIDs = $(this).val();
        dataTable.search.fixed("agency", function(str, rowData, dataIndex) {
          const $row = $(dataTable.row(dataIndex).node());
          return agencyIDs.includes($row.attr("data-agency-id"));
        }).draw();
    });

    $("#project_ids")
      .select2()
      .on("change", function (e) {
        const projectIDs = $(this).val();
        dataTable.search.fixed("project", function(str, rowData, dataIndex) {
          const $row = $(dataTable.row(dataIndex).node());
          return projectIDs.includes($row.attr("data-project-id"));
        }).draw();
    });

    $("form").attr("autocomplete", "off");

    $("select").keypress(function (event) {
      return cancelBackspace(event);
    });
    $("select").keydown(function (event) {
      return cancelBackspace(event);
    });

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

  function cancelBackspace(event) {
    if (event.keyCode == 8) {
      return false;
    }
  }
});
