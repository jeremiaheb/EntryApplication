class RegionsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /regions
  def index
    @regions = @regions.includes(:habitat_types).order(:name)
  end

  # GET /regions/new
  def new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  def create
    if @region.save
      redirect_to regions_url, notice: "Region was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /regions/1
  def update
    if @region.update(region_params)
      redirect_to regions_url, notice: "Region was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /regions/1
  def destroy
    if @region.destroy
      redirect_to regions_url, notice: "Region was successfully deleted."
    else
      redirect_to regions_url, alert: "Region was not deleted: #{@region.errors.full_messages.join(", ")}"
    end
  end

  private

  def region_params
    params.require(:region).permit(:name, habitat_type_ids: [])
  end
end
