class DashboardController < ApplicationController

  before_filter :authenticate_diver!

  def show
    if current_diver.role == 'admin'
      @boat_logs = BoatLog.all
      @boatlog_divers = RepLog.group(:diver_id).count(:id)
      @sample_divers = DiverSample.primary.group(:diver_id).count(:id)
    elsif current_diver.role == 'manager'
      @boat_logs = BoatLog.where( "boatlog_manager_id=?", current_diver.boatlog_manager_id )
      @boatlog_divers = RepLog.joins(station_log: :boat_log).where("boat_logs.boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
      @sample_divers = DiverSample.primary.joins(:sample).where("samples.boatlog_manager_id = ?", current_diver.boatlog_manager_id).group(:diver_id).count(:id)
    end
  
    @data_by_divers = {"boatlogs"=> @boatlog_divers, "samples" => @sample_divers} 
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boat_logs }
    end
  end
end
