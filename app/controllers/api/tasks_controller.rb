class Api::TasksController < Api::ApplicationController
  before_action :set_project
  before_action :set_task, only: [:update, :destroy, :position]

  def index
    @tasks = @project.tasks.order(position: :asc)
  end

  def create
    @task = @project.tasks.new task_params
    if @task.save
      head :ok
    else
      render 'error', formats: [:json], handlers: [:jbuilder], status: :bad_request
    end
  end

  def update
    if @task.update task_params
      head :ok
    else
      render 'error', formats: [:json], handlers: [:jbuilder], status: :bad_request
    end
  end

  def destroy
    @task.destroy
    head :ok
  end

  def position
    @task.insert_at params[:position].to_i
    head :ok
  end

  private

  def set_project
    @project = current_user.projects.where(id: params[:project_id]).first
    head :not_found unless @project
  end

  def set_task
    @task = @project.tasks.where(uuid: params[:id]).first
    head :not_found unless @task
  end

  def task_params
    params.require(:task).permit :uuid, :task_type, :status, :point, :title, :description, :position, :started_at, :finished_at
  end
end
