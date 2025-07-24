class JurisdictionsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  def index
    @jurisdictions = @jurisdictions.includes(:habitat_types).order(:name)
  end

  def new
  end

  def create
    if @jurisdiction.save
      redirect_to jurisdictions_path, notice: "Jurisdiction was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @jurisdiction.update(jurisdiction_params)
      redirect_to jurisdictions_path, notice: "Jurisdiction was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @jurisdiction.destroy
    redirect_to jurisdictions_path, notice: "Jurisdiction was successfully deleted."
  end

  private

  def jurisdiction_params
    params.require(:jurisdiction).permit(:name, habitat_type_ids: [])
  end
end
