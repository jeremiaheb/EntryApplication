class AgenciesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /agencies
  def index
    @agencies = @agencies.order(:name)
  end

  # GET /agencies/new
  def new
  end

  # GET /agencies/1/edit
  def edit
  end

  # POST /agencies
  def create
    if @agency.save
      redirect_to agencies_url, notice: "Agency was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /agencies/1
  def update
    if @agency.update(agency_params)
      redirect_to agencies_url, notice: "Agency was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /agencies/1
  def destroy
    if @agency.destroy
      redirect_to agencies_url, notice: "Agency was successfully deleted."
    else
      redirect_to agencies_url, alert: "Agency was not deleted: #{@agency.errors.full_messages.join(", ")}"
    end
  end

  private

  def agency_params
    params.require(:agency).permit(:name)
  end
end
