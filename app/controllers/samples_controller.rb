class SamplesController < ApplicationController

  before_action :authenticate_diver!
  #load_and_authorize_resource

  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  # GET /samples
  # GET /samples.json
  def index
    def proof_by_diver(d)
      Diver.find(d.id).diver_proofing_samples
    end
    if current_diver.role == 'admin'
      @samples = Sample.all
    elsif current_diver.role == 'manager'
      @samples = Sample.joins(:diver_samples).where( "diver_samples.diver_id=? AND diver_samples.primary_diver=? OR boatlog_manager_id=?", current_diver, true, current_diver.boatlog_manager_id ).uniq
    else
      @samples = current_diver.samples.merge(DiverSample.primary)
    end
    
     #@proofing_samples = current_diver.samples.merge(DiverSample.primary).order("sample_date") 
      @proofing_samples = current_diver.diver_proofing_samples
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @samples }
      format.xlsx
      format.pdf do

        pdf = SamplePdf.new(proof_by_diver(params[:diver_id]||= current_diver), params[:fishtype].to_s)
        send_data pdf.render, filename: "#{current_diver.lastname}_ProofingReport.pdf",
                              type: "application/pdf"
      
      end
    end
  end

  # GET /samples/1
  # GET /samples/1.json
  def show
    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample }
      format.pdf do
        pdf = SamplePdf.new(@sample)
        send_data pdf.render, filename: "sample_#{@sample.field_id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  # GET /samples/new
  # GET /samples/new.json
  def new
    @sample = Sample.new

    2.times { @sample.diver_samples.build }
    @sample.sample_animals.build


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample }
    end
  end

  # GET /samples/1/edit
  def edit
    @sample = Sample.find(params[:id])

  end
    
  # POST /samples
  # POST /samples.json
  def create
    @sample = Sample.new(params[:sample])

    respond_to do |format|
      if @sample.save
        format.html { redirect_to samples_path, notice: 'Sample was successfully created.' }
        format.json { render json: @sample, status: :created, location: @sample }
      else
        format.html { render action: "new" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /samples/1
  # PUT /samples/1.json
  def update
    @sample = Sample.find(params[:id])

    respond_to do |format|
      if @sample.update_attributes(params[:sample])
        format.html { redirect_to samples_path, notice: 'Sample was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /samples/1
  # DELETE /samples/1.json
  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy

    respond_to do |format|
      format.html { redirect_to samples_url }
      format.json { head :no_content }
    end
  end

  def proofing_template

    @sample = Sample.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample }
      format.pdf do
        pdf = SamplePdf.new(@sample)
        send_data pdf.render, filename: "sample_#{@sample.field_id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end
