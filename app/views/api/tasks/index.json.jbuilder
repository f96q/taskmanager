json.array! @tasks do |task|
  json.extract! task, :uuid, :task_type, :status, :point, :title, :description
end
