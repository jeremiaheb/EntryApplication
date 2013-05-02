class CoralDemographicsController < ApplicationController
  # GET /coral_demographics
  # GET /coral_demographics.json
  def index
    @coral_demographics = CoralDemographic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coral_demographics }
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
    @coral_demographic = CoralDemographic.new(params[:coral_demographic])

    respond_to do |format|
      if @coral_demographic.save
        format.html { redirect_to @coral_demographic, notice: 'Coral demographic was successfully created.' }
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
        format.html { redirect_to @coral_demographic, notice: 'Coral demographic was successfully updated.' }
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
end
