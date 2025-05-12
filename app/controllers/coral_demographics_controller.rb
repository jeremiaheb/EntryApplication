class CoralDemographicsController < ApplicationController

  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /coral_demographics
  # GET /coral_demographics.json
  def index
    def proof_by_diver(d)
      if d.is_a?(String) == true
        Diver.find(d).diver_proofing_coral_demo
      else 
        Diver.find(d.id).diver_proofing_coral_demo
      end
    end
    if current_diver.role == 'admin'
      @coral_demographics = CoralDemographic.all
    elsif current_diver.role == 'manager'
      @coral_demographics = CoralDemographic.where( "diver_id=? OR boatlog_manager_id=?", current_diver, current_diver.boatlog_manager_id )
    else
      @coral_demographics = current_diver.coral_demographics
    end

    @proofing_coral_demographics = current_diver.diver_proofing_coral_demo

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coral_demographics }
      format.xlsx
      format.pdf do 
        pdf = CoralDemographicPdf.new(proof_by_diver(params[:diver_id]||= current_diver))

        expires_now
        send_data pdf.render, filename: "#{current_diver.lastname}_CoralDemographicsReport.pdf",
                              type: "application/pdf"
      end
    end
  end

  # GET /coral_demographics/1
  # GET /coral_demographics/1.json
  def show
    @coral_demographic = CoralDemographic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coral_demographic }
    end
  end

  # GET /coral_demographics/new
  # GET /coral_demographics/new.json
  def new
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: nil)
    if @draft
      @coral_demographic = CoralDemographic.new(@draft.model_attributes)
    else
      @coral_demographic = CoralDemographic.new.tap do |c|
        c.diver_id ||= current_diver.id
        c.demographic_corals.build
      end
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coral_demographic }
    end
  end

  # GET /coral_demographics/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: params[:id])
    if @draft
      @coral_demographic.assign_attributes(@draft.model_attributes)
    end
  end

  # POST /coral_demographics
  # POST /coral_demographics.json
  def create
    @coral_demographic = CoralDemographic.new(params[:coral_demographic])

    respond_to do |format|
      if @coral_demographic.save
        Draft.destroy_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: nil)

        format.html { redirect_to coral_demographics_path, notice: 'Coral demographic was successfully created.' }
        format.json { render json: @coral_demographic, status: :created, location: @coral_demographic }
      else
        format.html { render action: "new" }
        format.json { render json: @coral_demographic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coral_demographics/1
  # PUT /coral_demographics/1.json
  def update
    @coral_demographic = CoralDemographic.find(params[:id])

    respond_to do |format|
      if @coral_demographic.update_attributes(params[:coral_demographic])
        Draft.destroy_for(diver_id: current_diver.id, model_klass: CoralDemographic, model_id: @coral_demographic.id)

        format.html { redirect_to coral_demographics_path, notice: 'Coral demographic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coral_demographic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coral_demographics/1
  # DELETE /coral_demographics/1.json
  def destroy
    @coral_demographic = CoralDemographic.find(params[:id])
    @coral_demographic.destroy

    respond_to do |format|
      format.html { redirect_to coral_demographics_url }
      format.json { head :no_content }
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
      model_attributes: params[:coral_demographic],
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
