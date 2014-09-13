class TemplateProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template_project, only: [:edit, :update, :destroy, :show]
  respond_to :html

  def index
    @template_projects = TemplateProject.where(user: current_user).order(created_at: :desc).page params[:page]
  end

  def new
    @template_project = TemplateProject.new user: current_user
  end

  def create
    @template_project = TemplateProject.new template_project_params
    @template_project.user = current_user
    flash[:success] = 'saved' if @template_project.save
    respond_with @template_project, location: template_projects_path
  end

  def edit
  end

  def update
    flash[:success] = 'saved' if @template_project.update template_project_params
    respond_with @template_project, location: template_projects_path
  end

  def destroy
    @template_project.destroy
    redirect_to template_projects_path
  end

  def show
  end

  private

  def set_template_project
    @template_project = TemplateProject.where(user: current_user, id: params[:id]).first
  end

  def template_project_params
    params.require(:template_project).permit :title
  end
end