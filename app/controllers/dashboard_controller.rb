class DashboardController < ApplicationController
  before_action :authenticate_diver!
  before_action :require_manager_or_admin!

  layout "application-uswds"

  def show
    if current_diver.admin?
      @missions = Mission.active
    else
      @missions = current_diver.missions_managed.active
    end
    @missions = @missions.includes(:region, :agency, :project)

    # Apply filters
    @filters = {
      region_id: Array(params[:region_ids]).map(&:to_i),
      agency_id: Array(params[:agency_ids]).map(&:to_i),
      project_id: Array(params[:project_ids]).map(&:to_i),
    }.reject { |_, v| v.empty? }
    @unfiltered_missions = @missions
    @missions = @missions.where(@filters)

    @sample_count_report = SampleCountReport.new(@missions)
    @crosscheck_report = CrosscheckReport.new(@missions)
    @possible_duplicate_report = PossibleDuplicateReport.new(@missions)
  end
end
