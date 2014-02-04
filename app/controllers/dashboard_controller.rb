class DashboardController < ApplicationController
 
  before_filter :authenticate_diver!
  authorize_resource
 
 def show
  #binding.pry
  boatlog_managers = []
  if current_diver.admin?
    @boat_logs      = BoatLog.all
    boatlog_managers = BoatlogManager.all
  else
    @boat_logs      = current_diver.boatlog_manager.boat_logs
    boatlog_managers = [current_diver.boatlog_manager]
  end

  @data_by_divers = {}

  boatlog_managers.each do |boatlog_manager|
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
 end
end
