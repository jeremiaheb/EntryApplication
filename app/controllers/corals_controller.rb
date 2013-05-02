class CoralsController < ApplicationController
  # GET /corals
  # GET /corals.json
  def index
    @corals = Coral.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @corals }
    end
  end

  # GET /corals/1
  # GET /corals/1.json
  def show
    @coral = Coral.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coral }
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
    @coral = Coral.new(params[:coral])

    respond_to do |format|
      if @coral.save
        format.html { redirect_to @coral, notice: 'Coral was successfully created.' }
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
      if @coral.update_attributes(params[:coral])
        format.html { redirect_to @coral, notice: 'Coral was successfully updated.' }
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
      format.html { redirect_to corals_url }
      format.json { head :no_content }
    end
  end
end
