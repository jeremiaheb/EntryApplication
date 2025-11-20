class BoatLogsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /boat_logs
  def index
    @boat_logs = @boat_logs.joins(:mission).includes(:station_logs, :region, :agency, :project)

    # Apply filters
    @filters = {
      "mission.region_id": Array(params[:region_ids]).map(&:to_i),
      "mission.agency_id": Array(params[:agency_ids]).map(&:to_i),
      "mission.project_id": Array(params[:project_ids]).map(&:to_i),
    }.reject { |_, v| v.empty? }
    @unfiltered_boat_logs = @boat_logs
    @boat_logs = @boat_logs.where(@filters)

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx do
        @boat_logs = @boat_logs.includes(station_logs: { rep_logs: :diver })

        # Prevent caching
        no_store
      end
    end
  end

  # GET /boat_logs/1
  def show
  end

  # GET /boat_logs/new
  def new
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: nil)
    if @draft
      @boat_log = @draft.assign_attributes_to(BoatLog.new)
    else
      @boat_log = BoatLog.new.tap do |bl|
        station = bl.station_logs.build
        2.times { station.rep_logs.build }
      end
    end
  end

  # GET /boat_logs/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: params[:id])
    if @draft
      @draft.assign_attributes_to(@boat_log)
    end
  end

  # POST /boat_logs
  def create
    if @boat_log.save
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: nil)
      redirect_to @boat_log, notice: "Boat log was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /boat_logs/1
  def update
    if @boat_log.update(boat_log_params)
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: @boat_log.id)
      redirect_to @boat_log, notice: "Boat log was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /boat_logs/1
  def destroy
    if @boat_log.destroy
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BoatLog, model_id: @boat_log.id)
      redirect_to boat_logs_url, notice: "Boat log was successfully deleted."
    else
      redirect_to boat_logs_url, alert: "Boat log was not deleted: #{@boat_log.errors.full_messages.join(", ")}"
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
      model_attributes: boat_log_params,
      sequence: params[:sequence],
      focused_dom_id: params[:focused_dom_id],
    )
    if draft.save
      render json: {}, status: :created
    else
      render json: draft.errors, status: :unprocessable_entity
    end
  end

  private

  def boat_log_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:boat_log).permit!
  end
end
