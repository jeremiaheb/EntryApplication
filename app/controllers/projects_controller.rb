class ProjectsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  layout "application-uswds"

  def index
    @projects = @projects.order(:name)
  end

  def new
  end

  def create
    if @project.save
      redirect_to projects_path, notice: "Project was successfully created."
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: "Project was successfully updated."
    else
      render "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
