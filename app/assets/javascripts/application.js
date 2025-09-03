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
//= require jquery-ui
//
//= require ./validations
//= require ./benthic_covers
//= require ./boat_logs
//= require ./coral_demographics
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
      ],
    });

    $("form").attr("autocomplete", "off");

    $("select").keypress(function (event) {
      return cancelBackspace(event);
    });
    $("select").keydown(function (event) {
      return cancelBackspace(event);
    });
  });

  function cancelBackspace(event) {
    if (event.keyCode == 8) {
      return false;
    }
  }
});
