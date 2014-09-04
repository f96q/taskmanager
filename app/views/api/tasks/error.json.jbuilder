json.array! @task.errors do |attribute, message|
  json.attribute message
  json.message message
end
