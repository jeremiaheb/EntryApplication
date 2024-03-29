class BenthicCoversController < ApplicationController

  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /benthic_covers
  # GET /benthic_covers.json
  def index
    def proof_by_diver(d)
      if d.is_a?(String)
        Diver.find(d).diver_proofing_benthic_cover
      else
        Diver.find(d.id).diver_proofing_benthic_cover
      end
    end
    if current_diver.role == 'admin'
      @benthic_covers = BenthicCover.all
    elsif current_diver.role == 'manager'
      @benthic_covers = BenthicCover.where( "diver_id=? OR boatlog_manager_id=?", current_diver, current_diver.boatlog_manager_id )
    else
      @benthic_covers = current_diver.benthic_covers
    end

    @proofing_bentic_covers = current_diver.diver_proofing_benthic_cover
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @benthic_covers }
      format.xlsx
      format.pdf do 

        pdf = BenthicCoverPdf.new(proof_by_diver(params[:diver_id]||= current_diver))
        send_data pdf.render, filename: "#{current_diver.lastname}_BenthicCoverReport.pdf",
                              type: "application/pdf"
      
      end
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
    @benthic_cover = BenthicCover.new(benthic_cover_params)

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
      if @benthic_cover.update_attributes!(benthic_cover_params)
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

  def benthic_cover_params

    params.require(:benthic_cover).permit(:id, '_destroy', :boatlog_manager_id, :diver_id, :buddy, :field_id, :sample_date, :sample_begin_time, :habitat_type_id, :meters_completed, :sample_description,
                                         point_intercepts_attributes: [:id, '_destroy', :cover_cat_id, :hardbottom_num, :softbottom_num, :rubble_num],
                                         rugosity_measure_attributes: [:id, '_destroy', :min_depth, :max_depth, :rug_meters_completed, :meter_mark_1,
                                                                      :meter_mark_2, :meter_mark_3, :meter_mark_4, :meter_mark_5, :meter_mark_6,
                                                                      :meter_mark_7, :meter_mark_8, :meter_mark_9, :meter_mark_10, :meter_mark_11,
                                                                      :meter_mark_12, :meter_mark_13, :meter_mark_14, :meter_mark_15],
                                         invert_belt_attributes: [:id, '_destroy', :lobster_num, :conch_num, :diadema_num],
                                         presence_belt_attributes: [:id, '_destroy', :a_cervicornis, :a_palmata, :d_cylindrus, :m_annularis, :m_faveolata, :m_franksi, :m_ferox])
  
  end

end
