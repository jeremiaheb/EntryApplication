class HabitatTypesController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource
  
  # GET /habitat_types
  # GET /habitat_types.json
  def index
    @habitat_types = HabitatType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @habitat_types }
    end
  end

  # GET /habitat_types/1
  # GET /habitat_types/1.json
  def show
    @habitat_type = HabitatType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @habitat_type }
    end
  end

  # GET /habitat_types/new
  # GET /habitat_types/new.json
  def new
    @habitat_type = HabitatType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @habitat_type }
    end
  end

  # GET /habitat_types/1/edit
  def edit
    @habitat_type = HabitatType.find(params[:id])
  end

  # POST /habitat_types
  # POST /habitat_types.json
  def create
    @habitat_type = HabitatType.new(habitat_type_params)

    respond_to do |format|
      if @habitat_type.save
        format.html { redirect_to @habitat_type, notice: 'Habitat type was successfully created.' }
        format.json { render json: @habitat_type, status: :created, location: @habitat_type }
      else
        format.html { render action: "new" }
        format.json { render json: @habitat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /habitat_types/1
  # PUT /habitat_types/1.json
  def update
    @habitat_type = HabitatType.find(params[:id])

    respond_to do |format|
      if @habitat_type.update(habitat_type_params)
        format.html { redirect_to @habitat_type, notice: 'Habitat type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @habitat_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /habitat_types/1
  # DELETE /habitat_types/1.json
  def destroy
    @habitat_type = HabitatType.find(params[:id])
    @habitat_type.destroy

    respond_to do |format|
      format.html { redirect_to habitat_types_url }
      format.json { head :no_content }
    end
  end

  private

  def habitat_type_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:habitat_type).permit!
  end
end
