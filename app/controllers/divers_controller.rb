class DiversController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /divers
  def index
    @divers = @divers.order(:diver_number)

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
  end

  # GET /divers/1/edit
  def edit
  end

  # POST /divers
  def create
    if @diver.save(context: :admin)
      redirect_to divers_url, notice: "Diver was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /divers/1
  def update
    saved = @diver.with_transaction_returning_status do
      @diver.assign_attributes(diver_params)
      @diver.save(context: :admin)
    end

    if saved
      redirect_to divers_url, notice: "Diver was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /divers/1
  def destroy
    if @diver.destroy
      redirect_to divers_url, notice: "Diver was successfully deleted."
    else
      redirect_to divers_url, alert: "Diver was not deleted: #{@diver.errors.full_messages.join(", ")}"
    end
  end

  private

  def diver_params
    allowed_keys = [
      :active, :diver_number, :diver_name, :username, :password, :password_confirmation, :email, :agency, :current_password,
    ]

    allowed_keys << :role if current_diver.admin?

    params.require(:diver).permit(*allowed_keys).tap do |params|
      params.delete(:password) if params[:password].blank?
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
  end
end
