json.array! template_projects do |template_project|
  json.extract! template_project, :title
  json.tasks template_project.tasks do |task|
    json.extract! task, :task_type, :point, :title, :description, :position
  end
end
