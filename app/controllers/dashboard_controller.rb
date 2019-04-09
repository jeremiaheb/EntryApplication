class DashboardController < ApplicationController
 
  before_action :authenticate_diver!
  before_action :manager_or_admin?
 
 def show
  #binding.pry
  if current_diver.admin?
    @boat_logs = BoatLog.all
    @dashSamples = Sample.all
    @dashBenthicCovers = BenthicCover.all
    @dashCoralDemographics = CoralDemographic.all
    @boatlog_managers = BoatlogManager.all
  else
    @boat_logs = current_diver.boatlog_manager.boat_logs
    @dashSamples = current_diver.boatlog_manager.samples
    @dashBenthicCovers = current_diver.boatlog_manager.benthic_covers
    @dashCoralDemographics = current_diver.boatlog_manager.coral_demographics
    @boatlog_managers = [current_diver.boatlog_manager]
  end

  @data_by_divers = {}

  @boatlog_managers.each do |boatlog_manager|
    boatlog_manager.divers_responsible_for.each do |diver|
      if !@data_by_divers.has_key?(diver)
        @data_by_divers[diver] = {
          "boat"   => 0,
          "sample" => 0,
          "lpi"    => 0,
          "demo"   => 0
        }
      end

      @data_by_divers[diver]["boat"] += boatlog_manager.boatlog_replicates_count_for_diver(diver)
      @data_by_divers[diver]["sample"] += boatlog_manager.samples_count_for_diver(diver)
      @data_by_divers[diver]["lpi"] += boatlog_manager.benthic_covers_count_for_diver(diver)
      @data_by_divers[diver]["demo"] += boatlog_manager.coral_demographics_count_for_diver(diver)
    end
  end
  @data_by_divers.sort_by { |diver, data| diver }

  def send_to_path(missing_field_id)
    if sample = @dashSamples.find_by_field_id(missing_field_id)
      sample_path(sample)
    elsif  benthic_cover = @dashBenthicCovers.find_by_field_id(missing_field_id)
      benthic_cover_path(benthic_cover)
    else
      coral_demographic = @dashCoralDemographics.find_by_field_id(missing_field_id)
      coral_demographic_path(coral_demographic)
    end
  end

 end
 
 helper_method :send_to_path


 protected

  def manager_or_admin?
    if current_diver.admin? || current_diver.manager?
      true
    else
      flash[:error] = "You are not authorized to see this page"
      redirect_to root_path
      false
    end
  end


end
