class CleanupsController < ApplicationController
  before_action :authenticate_diver!
  before_action :require_admin!

  # GET /cleanups/new
  def new
    @cleanup = Cleanup.new
  end

  # POST /cleanups
  def create
    @cleanup = Cleanup.new(cleanup_params)
    if @cleanup.valid?
      @cleanup.backup_and_cleanup!
      redirect_to root_url, notice: "Data cleanup job was successfully completed."
    else
      render "new"
    end
  end

  private

  def cleanup_params
    params.require(:cleanup).permit(region_ids: [], agency_ids: [], project_ids: [])
  end
end
