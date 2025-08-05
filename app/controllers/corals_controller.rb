class CoralsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /corals
  def index
    @corals = @corals.order(:code, :rank)
  end

  # GET /corals/new
  def new
  end

  # GET /corals/1/edit
  def edit
  end

  # POST /corals
  def create
    if @coral.save
      redirect_to corals_url, notice: "Coral was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /corals/1
  def update
    if @coral.update(coral_params)
      redirect_to corals_url, notice: "Coral was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /corals/1
  def destroy
    if @coral.destroy
      redirect_to corals_url, notice: "Coral was successfully deleted."
    else
      redirect_to corals_url, alert: "Coral was not deleted: #{@coral.errors.full_messages.join(", ")}"
    end
  end

  private

  def coral_params
    params.require(:coral).permit(:code, :scientific_name, :common_name, :short_code, :rank)
  end
end
