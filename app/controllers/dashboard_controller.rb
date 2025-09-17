class DashboardController < ApplicationController
  before_action :authenticate_diver!
  before_action :manager_or_admin?

  def show
    if current_diver.admin?
      @boatlog_managers = BoatlogManager.all
    else
      @boatlog_managers = [current_diver.boatlog_manager]
    end

    @sample_count_report = SampleCountReport.new(@boatlog_managers)
    @crosscheck_report = CrosscheckReport.new(@boatlog_managers)
  end

  protected

  def manager_or_admin?
    if current_diver.admin? || current_diver.manager?
      true
    else
      flash[:alert] = "You are not authorized to see this page"
      redirect_to root_path
      false
    end
  end
end
