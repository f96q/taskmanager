class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @projects = current_user.projects.order(created_at: :desc).page params[:page]
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new project_params
    flash[:success] = 'saved' if @project.save
    respond_with @project, location: projects_path
  end

  def edit
  end

  def update
    flash[:success] = 'saved' if @project.update project_params
    respond_with @project, location: projects_path
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = current_user.projects.find params[:id]
  end

  def project_params
    params.require(:project).permit :title
  end
end
