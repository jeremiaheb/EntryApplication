class ProjectsController < ApplicationController
  before_action :authenticate_diver!
  load_and_authorize_resource

  # GET /projects
  def index
    @projects = @projects.order(:name)
  end

  # GET /projects/new
  def new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    if @project.save
      redirect_to projects_url, notice: "Project was successfully created."
    else
      render action: "new"
    end
  end

  # PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to projects_url, notice: "Project was successfully updated."
    else
      render action: "edit"
    end
  end

  # DELETE /projects/1
  def destroy
    if @project.destroy
      redirect_to projects_url, notice: "Project was successfully deleted."
    else
      redirect_to projects_url, alert: "Project was not deleted: #{@project.errors.full_messages.join(", ")}"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
