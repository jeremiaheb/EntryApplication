class CoverCatsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  # GET /cover_cats
  def index
    @cover_cats = @cover_cats.order(:code, :rank)
  end

  # GET /cover_cats/new
  def new
  end

  # GET /cover_cats/1/edit
  def edit
  end

  # POST /cover_cats
  def create
    if @cover_cat.save
      redirect_to cover_cats_url, notice: "Cover cat was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /cover_cats/1
  def update
    if @cover_cat.update(cover_cat_params)
      redirect_to cover_cats_url, notice: "Cover cat was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /cover_cats/1
  def destroy
    if @cover_cat.destroy
      redirect_to cover_cats_url, notice: "Cover cat was successfully deleted."
    else
      redirect_to cover_cats_url, notice: "Cover cat was not deleted: #{@cover_cat.errors.full_messages.join(", ")}"
    end
  end

  private

  def cover_cat_params
    params.require(:cover_cat).permit(:code, :name, :common, :proofing_code, :rank)
  end
end
