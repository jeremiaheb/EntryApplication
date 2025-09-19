class DashboardController < ApplicationController
  before_action :authenticate_diver!
  before_action :require_manager_or_admin!

  layout "application-uswds"

  def show
    if current_diver.admin?
      @boatlog_managers = BoatlogManager.all
    else
      @boatlog_managers = [current_diver.boatlog_manager]
    end

    @sample_count_report = SampleCountReport.new(@boatlog_managers)
    @crosscheck_report = CrosscheckReport.new(@boatlog_managers)
    @possible_duplicate_report = PossibleDuplicateReport.new(@boatlog_managers)
  end
end
