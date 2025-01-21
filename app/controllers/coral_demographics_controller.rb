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
    @coral_demographic = CoralDemographic.new

    @coral_demographic.demographic_corals.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coral_demographic }
    end
  end

  # GET /coral_demographics/1/edit
  def edit
    @coral_demographic = CoralDemographic.find(params[:id])
  end

  # POST /coral_demographics
  # POST /coral_demographics.json
  def create
    @coral_demographic = CoralDemographic.new(coral_demographic_params)

    respond_to do |format|
      if @coral_demographic.save
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
      if @coral_demographic.update_attributes(coral_demographic_params)
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

  private

  def coral_demographic_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:coral_demographic).permit!
  end
end
