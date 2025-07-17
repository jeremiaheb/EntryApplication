class CoralsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /corals
  # GET /corals.json
  def index
    @corals = Coral.order(:code, :rank)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corals }
    end
  end

  # GET /corals/new
  # GET /corals/new.json
  def new
    @coral = Coral.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coral }
    end
  end

  # GET /corals/1/edit
  def edit
    @coral = Coral.find(params[:id])
  end

  # POST /corals
  # POST /corals.json
  def create
    @coral = Coral.new(coral_params)

    respond_to do |format|
      if @coral.save
        format.html { redirect_to corals_url, notice: "Coral was successfully created." }
        format.json { render json: @coral, status: :created, location: @coral }
      else
        format.html { render action: "new" }
        format.json { render json: @coral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /corals/1
  # PUT /corals/1.json
  def update
    @coral = Coral.find(params[:id])

    respond_to do |format|
      if @coral.update(coral_params)
        format.html { redirect_to corals_url, notice: "Coral was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corals/1
  # DELETE /corals/1.json
  def destroy
    @coral = Coral.find(params[:id])
    @coral.destroy

    respond_to do |format|
      format.html { redirect_to corals_url, notice: "Coral was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def coral_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:coral).permit!
  end
end
