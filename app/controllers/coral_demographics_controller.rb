class CoralDemographicsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /coral_demographics
  def index
    @coral_demographics = @coral_demographics.joins(:mission).includes(:diver, :region, :agency, :project)

    # Apply filters
    @filters = {
      "mission.region_id": Array(params[:region_ids]).map(&:to_i),
      "mission.agency_id": Array(params[:agency_ids]).map(&:to_i),
      "mission.project_id": Array(params[:project_ids]).map(&:to_i),
    }.reject { |_, v| v.empty? }
    @unfiltered_coral_demographics = @coral_demographics
    @coral_demographics = @coral_demographics.where(@filters)

    respond_to do |format|
      format.html # index.html.erb
      format.xlsx do
        # Prevent caching
        no_store
      end
      format.pdf do
        # Prevent caching
        no_store

        diver = Diver.find(params[:diver_id].presence || current_diver.id)
        @coral_demographics = @coral_demographics.
          where(diver: diver).
          includes(:habitat_type, demographic_corals: :coral).
          order(:sample_date, :sample_begin_time)
        pdf = CoralDemographicPdf.new(@coral_demographics)

        send_data pdf.render, filename: "#{diver.diver_name}_CoralDemographicsReport.pdf",
          type: "application/pdf"
      end
    end
  end

  # GET /coral_demographics/1
  def show
  end

  # GET /coral_demographics/new
  def new
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: nil)
    if @draft
      @coral_demographic = @draft.assign_attributes_to(CoralDemographic.new)
    else
      @coral_demographic = CoralDemographic.new.tap do |c|
        c.diver_id ||= current_diver.id
        c.demographic_corals.build
      end
    end
  end

  # GET /coral_demographics/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: params[:id])
    if @draft
      @draft.assign_attributes_to(@coral_demographic)
    end
  end

  # POST /coral_demographics
  def create
    if @coral_demographic.save
      Draft.destroy_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: nil)
      redirect_to coral_demographics_path, notice: "Coral demographic was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /coral_demographics/1
  def update
    if @coral_demographic.update(coral_demographic_params)
      Draft.destroy_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: @coral_demographic.id)
      redirect_to coral_demographics_path, notice: "Coral demographic was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /coral_demographics/1
  def destroy
    if @coral_demographic.destroy
      redirect_to coral_demographics_url, notice: "Coral demographic was successfully deleted."
    else
      redirect_to coral_demographics_url, alert: "Coral demographic was not deleted: #{@coral_demographic.errors.full_messages.join(", ")}"
    end
  end

  # PUT /draft
  def draft
    # Handle intentional delete of draft data
    unless params[:coral_demographic].present?
      Draft.destroy_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: params[:id])

      head :ok
      return
    end

    draft = Draft.new(
      diver_id: current_diver.id,
      model_klass: CoralDemographic,
      model_id: params[:id],
      model_attributes: coral_demographic_params,
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

  def coral_demographic_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:coral_demographic).permit!
  end
end
