class BenthicCoversController < ApplicationController

  before_filter :authenticate_diver!
  load_and_authorize_resource

  # GET /benthic_covers
  # GET /benthic_covers.json
  def index

    if current_diver.role == 'admin'
      @benthic_covers = BenthicCover.all
    elsif current_diver.role == 'manager'
      @benthic_covers = BenthicCover.where( "diver_id=? OR boatlog_manager_id=?", current_diver, current_diver.boatlog_manager_id )
    else
      @benthic_covers = current_diver.benthic_covers
    end


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @benthic_covers }
      format.xlsx
    end
  end

  # GET /benthic_covers/1
  # GET /benthic_covers/1.json
  def show
    @benthic_cover = BenthicCover.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @benthic_cover }
    end
  end

  # GET /benthic_covers/new
  # GET /benthic_covers/new.json
  def new
    @benthic_cover = BenthicCover.new

    @benthic_cover.build_invert_belt
    @benthic_cover.build_presence_belt
    @benthic_cover.point_intercepts.build
    @benthic_cover.build_rugosity_measure

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @benthic_cover }
    end
  end

  # GET /benthic_covers/1/edit
  def edit
    @benthic_cover = BenthicCover.find(params[:id])
  end

  # POST /benthic_covers
  # POST /benthic_covers.json
  def create
    @benthic_cover = BenthicCover.new(params[:benthic_cover])

    respond_to do |format|
      if @benthic_cover.save
        format.html { redirect_to benthic_covers_path, notice: 'Benthic cover was successfully created.' }
        format.json { render json: @benthic_cover, status: :created, location: @benthic_cover }
      else
        format.html { render action: "new" }
        format.json { render json: @benthic_cover.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /benthic_covers/1
  # PUT /benthic_covers/1.json
  def update
    @benthic_cover = BenthicCover.find(params[:id])

    respond_to do |format|
      if @benthic_cover.update_attributes(params[:benthic_cover])
        format.html { redirect_to benthic_covers_path, notice: 'Benthic cover was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @benthic_cover.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /benthic_covers/1
  # DELETE /benthic_covers/1.json
  def destroy
    @benthic_cover = BenthicCover.find(params[:id])
    @benthic_cover.destroy

    respond_to do |format|
      format.html { redirect_to benthic_covers_url }
      format.json { head :no_content }
    end
  end
end
