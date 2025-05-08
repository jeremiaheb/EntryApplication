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
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: nil)
    if @draft
      @boat_log = BoatLog.new(@draft.model_attributes)
    else
      @boat_log = BoatLog.new.tap do |bl|
        station = bl.station_logs.build
        2.times { station.rep_logs.build }
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boat_log }
    end
  end

  # GET /boat_logs/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: params[:id])
    if @draft
      @boat_log.assign_attributes(@draft.model_attributes)
    end
  end

  # POST /boat_logs
  # POST /boat_logs.json
  def create
    @boat_log = BoatLog.new(params[:boat_log])

    respond_to do |format|
      if @boat_log.save
        Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: nil)

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
        Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: @boat_log.id)

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

  # PUT /draft
  def draft
    # Handle intentional delete of draft data
    unless params[:boat_log].present?
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: params[:id])

      head :ok
      return
    end

    draft = Draft.new(
      diver_id: current_diver.id,
      model_klass: BoatLog,
      model_id: params[:id],
      model_attributes: params[:boat_log],
      sequence: params[:sequence],
      focused_dom_id: params[:focused_dom_id],
    )
    if draft.save
      render json: {}, status: :created
    else
      render json: draft.errors, status: :unprocessable_entity
    end
  end
end
