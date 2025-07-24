class AgenciesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  def index
    @agencies = @agencies.order(:name)
  end

  def new
  end

  def create
    if @agency.save
      redirect_to agencies_path, notice: "Agency was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @agency.update(agency_params)
      redirect_to agencies_path, notice: "Agency was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @agency.destroy
    redirect_to agencies_path, notice: "Agency was successfully deleted."
  end

  private

  def agency_params
    params.require(:agency).permit(:name)
  end
end
