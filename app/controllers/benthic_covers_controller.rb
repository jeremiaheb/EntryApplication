class BenthicCoversController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds", only: [:index]

  # GET /benthic_covers
  def index
    if current_diver.role == "admin"
      @benthic_covers = @benthic_covers.all
    elsif current_diver.role == "manager"
      @benthic_covers = @benthic_covers.where("diver_id=? OR boatlog_manager_id=?", current_diver, current_diver.boatlog_manager_id)
    else
      @benthic_covers = current_diver.benthic_covers
    end

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
        benthic_covers = diver.benthic_covers.
          includes(:boatlog_manager, :habitat_type, :rugosity_measure, :invert_belt, :presence_belt, point_intercepts: :cover_cat).
          order(:sample_date, :sample_begin_time)
        pdf = BenthicCoverPdf.new(benthic_covers)

        send_data pdf.render, filename: "#{diver.diver_name}_BenthicCoverReport.pdf",
          type: "application/pdf"
      end
    end
  end

  # GET /benthic_covers/1
  def show
  end

  # GET /benthic_covers/new
  def new
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BenthicCover, model_id: nil)
    if @draft
      @benthic_cover = @draft.assign_attributes_to(BenthicCover.new)
    else
      @benthic_cover = BenthicCover.new.tap do |b|
        b.diver_id ||= current_diver.id
        b.build_invert_belt
        b.build_presence_belt
        b.point_intercepts.build
        b.build_rugosity_measure
      end
    end
  end

  # GET /benthic_covers/1/edit
  def edit
    @draft = Draft.latest_for(diver_id: current_diver.id, model_klass: BenthicCover, model_id: params[:id])
    if @draft
      @draft.assign_attributes_to(@benthic_cover)
    end
  end

  # POST /benthic_covers
  def create
    if @benthic_cover.save
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BenthicCover, model_id: nil)
      redirect_to benthic_covers_path, notice: "Benthic cover was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /benthic_covers/1
  def update
    if @benthic_cover.update(benthic_cover_params)
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BenthicCover, model_id: @benthic_cover.id)
      redirect_to benthic_covers_path, notice: "Benthic cover was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /benthic_covers/1
  def destroy
    if @benthic_cover.destroy
      redirect_to benthic_covers_url, notice: "Benthic cover was successfully deleted."
    else
      redirect_to benthic_covers_url, alert: "Benthic cover was not deleted: #{@benthic_cover.errors.full_messages.join(", ")}"
    end
  end

  # PUT /draft
  def draft
    # Handle intentional delete of draft data
    unless params[:benthic_cover].present?
      Draft.destroy_for(diver_id: current_diver.id, model_klass: BenthicCover, model_id: params[:id])

      head :ok
      return
    end

    draft = Draft.new(
      diver_id: current_diver.id,
      model_klass: BenthicCover,
      model_id: params[:id],
      model_attributes: benthic_cover_params,
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

  def benthic_cover_params
    params.require(:benthic_cover).permit(:id, "_destroy", :boatlog_manager_id, :diver_id, :buddy_id, :field_id, :sample_date, :sample_begin_time, :habitat_type_id, :meters_completed, :sample_description,
                                         point_intercepts_attributes: [:id, "_destroy", :cover_cat_id, :hardbottom_num, :softbottom_num, :rubble_num],
                                         rugosity_measure_attributes: [:id, "_destroy", :min_depth, :max_depth, :rug_meters_completed, :meter_mark_1,
                                                                      :meter_mark_2, :meter_mark_3, :meter_mark_4, :meter_mark_5, :meter_mark_6,
                                                                      :meter_mark_7, :meter_mark_8, :meter_mark_9, :meter_mark_10, :meter_mark_11,
                                                                      :meter_mark_12, :meter_mark_13, :meter_mark_14, :meter_mark_15,],
                                         invert_belt_attributes: [:id, "_destroy", :lobster_num, :conch_num, :diadema_num],
                                         presence_belt_attributes: [:id, "_destroy", :a_cervicornis, :a_palmata, :d_cylindrus, :m_annularis, :m_faveolata, :m_franksi, :m_ferox])
  end
end
