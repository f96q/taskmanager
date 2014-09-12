class TaskProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_project, only: [:edit, :update, :destroy, :show]
  before_action :set_template_projects, only: [:new, :create]
  respond_to :html

  def index
    @task_projects = TaskProject.where(user: current_user).order(created_at: :desc).page params[:page]
  end

  def new
    @task_project = TaskProject.new user: current_user
  end

  def create
    if params[:template_project_id].present?
      @template_project = TemplateProject.find params[:template_project_id]
      @task_project = TaskProjectDuplicator.execute @template_project, params
    else
      @task_project = TaskProject.new task_project_params
    end
    @task_project.user = current_user
    flash[:success] = 'saved' if @task_project.save
    respond_with @task_project, location: task_projects_path
  end

  def edit
  end

  def update
    flash[:success] = 'saved' if @task_project.update task_project_params
    respond_with @task_project, location: task_projects_path
  end

  def destroy
    @task_project.destroy
    redirect_to task_projects_path
  end

  def show
  end

  private

  def set_task_project
    @task_project = TaskProject.where(user: current_user, id: params[:id]).first
  end

  def set_template_projects
    @template_projects = TemplateProject.where user: current_user
  end

  def task_project_params
    params.require(:task_project).permit :title
  end
end
