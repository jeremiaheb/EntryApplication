class AnimalsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /animals
  def index
    @animals = @animals.order(:scientific_name)

    respond_to do |format|
      format.html
      format.xlsx do
        # Prevent caching
        no_store
      end
    end
  end

  # GET /animals/new
  def new
  end

  # GET /animals/1/edit
  def edit
  end

  # POST /animals
  def create
    if @animal.save
      redirect_to animals_url, notice: "Animal was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /animals/1
  def update
    if @animal.update(animal_params)
      redirect_to animals_url, notice: "Animal was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /animals/1
  def destroy
    if @animal.destroy
      redirect_to animals_url, notice: "Animal was successfully deleted."
    else
      redirect_to animals_url, alert: "Animal was not deleted: #{@animal.errors.full_messages.join(", ")}"
    end
  end

  private

  def animal_params
    params.require(:animal).permit(:species_code, :scientific_name, :common_name, :min_size, :max_size, :max_number)
  end
end
