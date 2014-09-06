class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @project = Project.where(id: params[:project_id]).first
  end
end
