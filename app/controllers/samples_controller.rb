class SamplesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds", only: [:index]

  # GET /samples
  def index
    @samples = @samples.includes(:diver)
    if current_diver.admin?
      @samples = @samples.all
    elsif current_diver.manager?
      @samples = @samples.where("diver_id=? OR boatlog_manager_id=?", current_diver.id, current_diver.boatlog_manager_id)
    else
      @samples = @samples.where("diver_id=?", current_diver.id)
    end

    respond_to do |format|
      format.html
      format.xlsx do
        # Prevent caching
        no_store
      end
      format.pdf do
        # Prevent caching
        no_store

        diver = Diver.find(params[:diver_id].presence || current_diver.id)
        samples = diver.samples.
          includes(:boatlog_manager, :buddy, :habitat_type, sample_animals: :animal).
          order(:sample_date, :sample_begin_time)
        pdf = SamplePdf.new(samples, params[:fishtype].to_s)

        send_data pdf.render, filename: "#{diver.diver_name}_ProofingReport.pdf",
          type: "application/pdf"
      end
    end
  end

  # GET /samples/1
  def show
  end

  # GET /samples/new
  def new
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: Sample, model_id: nil)
    if @draft
      @draft.assign_attributes_to(@sample)
    else
      @sample.diver_id = current_diver.id
      @sample.sample_type = SampleType.default
      @sample.sample_animals.build
    end
  end

  # GET /samples/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: Sample, model_id: params[:id])
    if @draft
      @draft.assign_attributes_to(@sample)
    end
  end

  # POST /samples
  def create
    if @sample.save
      Draft.destroy_for(diver_id: current_diver.id, model_klass: Sample, model_id: nil)
      redirect_to samples_url, notice: "Sample was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /samples/1
  def update
    if @sample.update(sample_params)
      Draft.destroy_for(diver_id: current_diver.id, model_klass: Sample, model_id: @sample.id)
      redirect_to samples_url, notice: "Sample was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /samples/1
  def destroy
    if @sample.destroy
      redirect_to samples_url, notice: "Sample was successfully deleted."
    else
      redirect_to samples_url, alert: "Sample was not deleted: #{@sample.errors.full_messages.join(", ")}"
    end
  end

  # PUT /draft
  def draft
    # Handle intentional delete of draft data
    unless params[:sample].present?
      Draft.destroy_for(diver_id: current_diver.id, model_klass: Sample, model_id: params[:id])

      head :ok
      return
    end

    draft = Draft.new(
      diver_id: current_diver.id,
      model_klass: Sample,
      model_id: params[:id],
      model_attributes: sample_params,
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

  def sample_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:sample).permit!
  end
end
