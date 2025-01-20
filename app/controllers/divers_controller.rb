class DiversController < ApplicationController
 
  
  before_action :authenticate_diver!
  load_and_authorize_resource
  
  # GET /divers
  # GET /divers.json
  def index
    @divers = Diver.order(:diver_number).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @divers }
      format.xlsx
    end
  end

  # GET /divers/1
  # GET /divers/1.json
  def show
    @diver = Diver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diver }
    end
  end

  # GET /divers/new
  # GET /divers/new.json
  def new
    @diver = Diver.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diver }
    end
  end

  # GET /divers/1/edit
  def edit
    @diver = Diver.find(params[:id])
  end

  # POST /divers
  # POST /divers.json
  def create
    @diver = Diver.new(diver_params)

    respond_to do |format|
      if @diver.save
        format.html { redirect_to @diver, notice: 'Diver was successfully created.' }
        format.json { render json: @diver, status: :created, location: @diver }
      else
        format.html { render action: "new" }
        format.json { render json: @diver.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /divers/1
  # PUT /divers/1.json
  def update
    @diver = Diver.find(params[:id])

    respond_to do |format|
      if @diver.update_attributes(diver_params)
        format.html { redirect_to @diver, notice: 'Diver was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diver.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /divers/1
  # DELETE /divers/1.json
  def destroy
    @diver = Diver.find(params[:id])
    @diver.destroy

    respond_to do |format|
      format.html { redirect_to divers_url }
      format.json { head :no_content }
    end
  end

  private

  def diver_params
    # TODO: TEST THIS
    allowed_keys = [
      :email, :password, :password_confirmation, :username, :firstname,
      :lastname, :current_password, :boatlog_manager_id
    ]

    allowed_keys << :role if current_diver.admin?

    params.require(:diver).permit(*allowed_keys)
  end
end
