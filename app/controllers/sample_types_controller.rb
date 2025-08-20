class SampleTypesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /sample_types
  def index
    @sample_types = @sample_types.order(:sample_type_name)
  end

  # GET /sample_types/new
  def new
  end

  # GET /sample_types/1/edit
  def edit
  end

  # POST /sample_types
  def create
    if @sample_type.save
      redirect_to sample_types_url, notice: "Sample type was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /sample_types/1
  def update
    if @sample_type.update(sample_type_params)
      redirect_to sample_types_url, notice: "Sample type was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /sample_types/1
  def destroy
    if @sample_type.destroy
      redirect_to sample_types_url, notice: "Sample type was successfully deleted."
    else
      redirect_to sample_types_url, alert: "Sample type was not deleted: #{@sample_type.errors.full_messages.join(", ")}"
    end
  end

  private

  def sample_type_params
    params.require(:sample_type).permit(:sample_type_name, :sample_type_description)
  end
end
