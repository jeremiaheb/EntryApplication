class MissionsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  def index
    @missions = @missions.includes(:region, :agency, :project, :managers).standard_order
  end

  def new
  end

  def create
    if @mission.save
      redirect_to missions_path, notice: "Mission was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @mission.update(mission_params)
      redirect_to missions_path, notice: "Mission was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_path, notice: "Mission was successfully deleted."
  end

  private

  def mission_params
    params.require(:mission).permit(:project_id, :agency_id, :region_id, manager_ids: [])
  end
end
