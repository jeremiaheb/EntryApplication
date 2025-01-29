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
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require bootstrap-datepicker
//= require select2
//= require jquery.validate
//= require bootstrap
//= require jquery-ui/datepicker
//= require jquery_nested_form
//= require underscore-umd
//= require_tree ../../../vendor/assets/javascripts
//
//= require ./benthic_covers
//= require ./boat_logs
//= require ./coral_demographics
//= require ./samples
//= require ./static_pages
//= require ./drafts
//= require_self

// Set up our EA namespace for our functions
var EA = {};
EA.onRailsPage = function(railsController, railsActions) {
  var selector = _.map(railsActions, function(action) {
    return "body." + railsController + "." + action;
  }).join(', ');


  return $(selector).length > 0;
}

$(function(){
    $('tr[data-link]').click(function(){
      window.location = this.dataset.link
    });

    $('tr[data-link]').hover(
      function(){
        $(this).css("background", "yellow");
        $(this).css("cursor", "pointer");
      },
      function(){
        $(this).css("background", "");
      }
    );
    

    $(document).ready(function(){

    $('.display').DataTable( {
        //"sDom": "<'row'<'span7'lf>r>t<'row'<'span7'ip>>",
        "sDom": '<"top"ifp<"clear">>rt<"bottom"<"clear">>',
        "pagingType": "full"
    } );



      $('form').attr('autocomplete', 'off');

      $('select').keypress(function(event) 
        { return cancelBackspace(event) });
      $('select').keydown(function(event) 
        { return cancelBackspace(event) });
    });

    function cancelBackspace(event) {
      if (event.keyCode == 8) {
        return false;
      }
    }

});
