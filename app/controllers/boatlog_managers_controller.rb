class BoatlogManagersController < ApplicationController
  
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /boatlog_managers
  # GET /boatlog_managers.json
  def index
    @boatlog_managers = BoatlogManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boatlog_managers }
    end
  end

  # GET /boatlog_managers/1
  # GET /boatlog_managers/1.json
  def show
    @boatlog_manager = BoatlogManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boatlog_manager }
    end
  end

  # GET /boatlog_managers/new
  # GET /boatlog_managers/new.json
  def new
    @boatlog_manager = BoatlogManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boatlog_manager }
    end
  end

  # GET /boatlog_managers/1/edit
  def edit
    @boatlog_manager = BoatlogManager.find(params[:id])
  end

  # POST /boatlog_managers
  # POST /boatlog_managers.json
  def create
    @boatlog_manager = BoatlogManager.new(params[:boatlog_manager])

    respond_to do |format|
      if @boatlog_manager.save
        format.html { redirect_to @boatlog_manager, notice: 'Boatlog manager was successfully created.' }
        format.json { render json: @boatlog_manager, status: :created, location: @boatlog_manager }
      else
        format.html { render action: "new" }
        format.json { render json: @boatlog_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boatlog_managers/1
  # PUT /boatlog_managers/1.json
  def update
    @boatlog_manager = BoatlogManager.find(params[:id])

    respond_to do |format|
      if @boatlog_manager.update_attributes(params[:boatlog_manager])
        format.html { redirect_to @boatlog_manager, notice: 'Boatlog manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boatlog_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boatlog_managers/1
  # DELETE /boatlog_managers/1.json
  def destroy
    @boatlog_manager = BoatlogManager.find(params[:id])
    @boatlog_manager.destroy

    respond_to do |format|
      format.html { redirect_to boatlog_managers_url }
      format.json { head :no_content }
    end
  end
end
