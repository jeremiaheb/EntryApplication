class MissionsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /missions
  def index
    @missions = @missions.includes(:region, :agency, :project, :manager_divers).standard_order
  end

  # GET /missions/new
  def new
  end

  # GET /missions/1/edit
  def edit
  end

  # POST /missions
  def create
    if @mission.save
      redirect_to missions_url, notice: "Mission was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /missions/1
  def update
    if @mission.update(mission_params)
      redirect_to missions_url, notice: "Mission was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /missions/1
  def destroy
    if @mission.destroy
      redirect_to missions_url, notice: "Mission was successfully deleted."
    else
      redirect_to missions_url, alert: "Mission was not deleted: #{@mission.errors.full_messages.join(", ")}"
    end
  end

  private

  def mission_params
    params.require(:mission).permit(:active, :project_id, :agency_id, :region_id, manager_diver_ids: [])
  end
end
