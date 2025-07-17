class SampleTypesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /sample_types
  # GET /sample_types.json
  def index
    @sample_types = SampleType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sample_types }
    end
  end

  # GET /sample_types/1
  # GET /sample_types/1.json
  def show
    @sample_type = SampleType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sample_type }
    end
  end

  # GET /sample_types/new
  # GET /sample_types/new.json
  def new
    @sample_type = SampleType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sample_type }
    end
  end

  # GET /sample_types/1/edit
  def edit
    @sample_type = SampleType.find(params[:id])
  end

  # POST /sample_types
  # POST /sample_types.json
  def create
    @sample_type = SampleType.new(sample_type_params)

    respond_to do |format|
      if @sample_type.save
        format.html { redirect_to @sample_type, notice: "Sample type was successfully created." }
        format.json { render json: @sample_type, status: :created, location: @sample_type }
      else
        format.html { render action: "new" }
        format.json { render json: @sample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sample_types/1
  # PUT /sample_types/1.json
  def update
    @sample_type = SampleType.find(params[:id])

    respond_to do |format|
      if @sample_type.update(sample_type_params)
        format.html { redirect_to @sample_type, notice: "Sample type was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sample_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sample_types/1
  # DELETE /sample_types/1.json
  def destroy
    @sample_type = SampleType.find(params[:id])
    @sample_type.destroy

    respond_to do |format|
      format.html { redirect_to sample_types_url }
      format.json { head :no_content }
    end
  end

  private

  def sample_type_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:sample_type).permit!
  end
end
