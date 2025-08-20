class BoatlogManagersController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /boatlog_managers
  def index
    @boatlog_managers = @boatlog_managers.order(:agency, :lastname)
  end

  # GET /boatlog_managers/new
  def new
  end

  # GET /boatlog_managers/1/edit
  def edit
  end

  # POST /boatlog_managers
  def create
    if @boatlog_manager.save
      redirect_to boatlog_managers_url, notice: "Boatlog manager was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /boatlog_managers/1
  def update
    if @boatlog_manager.update(boatlog_manager_params)
      redirect_to boatlog_managers_url, notice: "Boatlog manager was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /boatlog_managers/1
  def destroy
    @boatlog_manager = BoatlogManager.find(params[:id])
    if @boatlog_manager.destroy
      redirect_to boatlog_managers_url, notice: "Boatlog manager was successfully deleted."
    else
      redirect_to boatlog_managers_url, alert: "Boatlog manager was not deleted: #{@boatlog_manager.errors.full_messages.join(", ")}"
    end
  end

  private

  def boatlog_manager_params
    params.require(:boatlog_manager).permit(:agency, :firstname, :lastname)
  end
end
