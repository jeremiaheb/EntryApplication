class HabitatTypesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /habitat_types
  def index
    @habitat_types = @habitat_types.order(:habitat_name)
  end

  # GET /habitat_types/new
  def new
  end

  # GET /habitat_types/1/edit
  def edit
  end

  # POST /habitat_types
  def create
    if @habitat_type.save
      redirect_to habitat_types_url, notice: "Habitat type was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /habitat_types/1
  def update
    if @habitat_type.update(habitat_type_params)
      redirect_to habitat_types_url, notice: "Habitat type was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /habitat_types/1
  def destroy
    if @habitat_type.destroy
      redirect_to habitat_types_url, notice: "Habitat type was successfully deleted."
    else
      redirect_to habitat_types_url, alert: "Habitat type was not deleted: #{@habitat_type.errors.full_messages.join(", ")}"
    end
  end

  private

  def habitat_type_params
    params.require(:habitat_type).permit(:habitat_name, :habitat_description, :region)
  end
end
