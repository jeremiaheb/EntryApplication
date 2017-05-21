class BoatLogsController < ApplicationController
  
  before_action :authenticate_diver!
  load_and_authorize_resource
  
  # GET /boat_logs
  # GET /boat_logs.json
  def index
    if current_diver.role == 'admin'
      @boat_logs = BoatLog.all
    elsif current_diver.role == 'manager'
      @boat_logs = BoatLog.where( "boatlog_manager_id=?", current_diver.boatlog_manager_id )
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boat_logs }
      format.xlsx
    end
  end

  # GET /boat_logs/1
  # GET /boat_logs/1.json
  def show
    @boat_log = BoatLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boat_log }
    end
  end

  # GET /boat_logs/new
  # GET /boat_logs/new.json
  def new
    @boat_log = BoatLog.new
    2.times do
      station = @boat_log.station_logs.build
      2.times { station.rep_logs.build }
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boat_log }
    end
  end

  # GET /boat_logs/1/edit
  def edit
    @boat_log = BoatLog.find(params[:id])
  end

  # POST /boat_logs
  # POST /boat_logs.json
  def create
    @boat_log = BoatLog.new(params[:boat_log])

    respond_to do |format|
      if @boat_log.save
        format.html { redirect_to @boat_log, notice: 'Boat log was successfully created.' }
        format.json { render json: @boat_log, status: :created, location: @boat_log }
      else
        format.html { render action: "new" }
        format.json { render json: @boat_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boat_logs/1
  # PUT /boat_logs/1.json
  def update
    @boat_log = BoatLog.find(params[:id])

    respond_to do |format|
      if @boat_log.update_attributes(params[:boat_log])
        format.html { redirect_to @boat_log, notice: 'Boat log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boat_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boat_logs/1
  # DELETE /boat_logs/1.json
  def destroy
    @boat_log = BoatLog.find(params[:id])
    @boat_log.destroy

    respond_to do |format|
      format.html { redirect_to boat_logs_url }
      format.json { head :no_content }
    end
  end
end
