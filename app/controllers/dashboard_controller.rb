class DashboardController < ApplicationController
 
  before_filter :authenticate_diver!
  authorize_resource
 
 def show
   @data_by_divers = Dashboard.new.divers(current_diver)
 end
end
