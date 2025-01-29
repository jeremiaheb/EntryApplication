class DraftsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  def create
    draft = Draft.for(current_diver.id, params[:model_type], params[:model], )
  end

  def latest
  end

  def destroy
  end
end
