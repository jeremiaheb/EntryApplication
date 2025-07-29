class RegionsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  def index
    @regions = @regions.includes(:habitat_types).order(:name)
  end

  def new
  end

  def create
    if @region.save
      redirect_to regions_path, notice: "Region was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @region.update(region_params)
      redirect_to regions_path, notice: "Region was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @region.destroy
    redirect_to regions_path, notice: "Region was successfully deleted."
  end

  private

  def region_params
    params.require(:region).permit(:name, habitat_type_ids: [])
  end
end
