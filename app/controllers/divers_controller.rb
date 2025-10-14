class DiversController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /divers
  def index
    @divers = Diver.order(:diver_number)

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx do
        # Prevent caching
        no_store
      end
    end
  end

  # GET /divers/new
  def new
    @diver = Diver.new
  end

  # GET /divers/1/edit
  def edit
    @diver = Diver.find(params[:id])
  end

  # POST /divers
  def create
    @diver = Diver.new(diver_params)

    if @diver.save
      redirect_to divers_url, notice: "Diver was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /divers/1
  def update
    @diver = Diver.find(params[:id])

    if @diver.update(diver_params)
      redirect_to divers_url, notice: "Diver was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /divers/1
  def destroy
    @diver = Diver.find(params[:id])
    @diver.destroy

    redirect_to divers_url, notice: "Diver was successfully deleted."
  end

  private

  def diver_params
    allowed_keys = [
      :active, :diver_number, :diver_name, :username, :password, :password_confirmation, :email, :current_password, :boatlog_manager_id,
    ]

    allowed_keys << :role if current_diver.admin?

    params.require(:diver).permit(*allowed_keys)
  end
end
