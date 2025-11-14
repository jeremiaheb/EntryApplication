$(function () {
  if (!EA.onRailsPage("missions", ["edit", "new", "create", "update"])) {
    return;
  }

  $("#mission_manager_diver_ids").select2();
});
