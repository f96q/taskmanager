class TaskProjectDuplicator
  def initialize(template_project, params)
    @template_project = template_project
    @params = params
  end

  def self.execute(template_project, params)
    new(template_project, params).execute
  end

  def execute
    TaskProject.new task_project_params
  end

  def params
    @params[:task_project].merge! tasks_attributes: @template_project.tasks.map {|task| attributes task }
    @params
  end

  def attributes(task)
    {
      uuid: SecureRandom.uuid,
      task_type: task.task_type,
      status: 'unstarted',
      point: task.point,
      title: task.title,
      description: task.description,
      position: task.position
    }
  end

  def task_project_params
    params.require(:task_project).permit :title, {tasks_attributes: [:id, :uuid, :task_type, :status, :point, :title, :description, :position] }
  end
end
