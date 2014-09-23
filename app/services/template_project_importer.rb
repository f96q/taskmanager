class TemplateProjectImporter
  def initialize(user, data)
    @user = user
    @template_projects = JSON.parse data
  end

  def self.execute(user, data)
    new(user, data).execute
  end

  def execute
    TemplateProject.transaction do
      @template_projects.each {|template_project| TemplateProject.new(parse_template_project(template_project)).save! }
    end
  end

  def parse_template_project(params)
    {
      user_id: @user.id,
      title: params['title'],
      tasks_attributes: params['tasks'].map {|task| parse_task task }
    }
  end

  def parse_task(params)
    {
      uuid: SecureRandom.uuid,
      task_type: params['task_type'],
      status: 'unstarted',
      point: params['point'],
      title: params['title'],
      description: params['description'],
      position: params['position']
    }
  end
end
