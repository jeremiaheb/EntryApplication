class DashboardController < ApplicationController
 
  before_filter :authenticate_diver!
  authorize_resource
 
 def show
  #binding.pry
  if current_diver.role == "admin"
    @boat_logs      = BoatLog.all
  else
    @boat_logs      = BoatLog.where( "boatlog_manager_id=?", current_diver.boatlog_manager_id )
  end
   @data_by_divers = Dashboard.new.divers(current_diver)
 end
end
