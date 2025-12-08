$(function () {
  if (!EA.onRailsPage("cleanups", ["edit", "new", "create", "update"])) {
    return;
  }

  $("#cleanup_region_ids, #cleanup_agency_ids, #cleanup_project_ids").select2();
});
