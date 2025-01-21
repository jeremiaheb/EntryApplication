class CoverCatsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /cover_cats
  # GET /cover_cats.json
  def index
    @cover_cats = CoverCat.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cover_cats }
    end
  end

  # GET /cover_cats/1
  # GET /cover_cats/1.json
  def show
    @cover_cat = CoverCat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cover_cat }
    end
  end

  # GET /cover_cats/new
  # GET /cover_cats/new.json
  def new
    @cover_cat = CoverCat.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cover_cat }
    end
  end

  # GET /cover_cats/1/edit
  def edit
    @cover_cat = CoverCat.find(params[:id])
  end

  # POST /cover_cats
  # POST /cover_cats.json
  def create
    @cover_cat = CoverCat.new(cover_cat_params)

    respond_to do |format|
      if @cover_cat.save
        format.html { redirect_to @cover_cat, notice: 'Cover cat was successfully created.' }
        format.json { render json: @cover_cat, status: :created, location: @cover_cat }
      else
        format.html { render action: "new" }
        format.json { render json: @cover_cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cover_cats/1
  # PUT /cover_cats/1.json
  def update
    @cover_cat = CoverCat.find(params[:id])

    respond_to do |format|
      if @cover_cat.update(cover_cat_params)
        format.html { redirect_to @cover_cat, notice: 'Cover cat was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cover_cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cover_cats/1
  # DELETE /cover_cats/1.json
  def destroy
    @cover_cat = CoverCat.find(params[:id])
    @cover_cat.destroy

    respond_to do |format|
      format.html { redirect_to cover_cats_url }
      format.json { head :no_content }
    end
  end

  private

  def cover_cat_params
    # TODO: Allowing all keys is intentional to reduce risk of a Rails upgrade.
    # Prior to Rails 7, the application used `attr_protected []` at the model
    # level. Mass attribute protection will be introduced gradually separate
    # from the Rails upgrade itself.
    params.require(:cover_cat).permit!
  end
end
