# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = @app

$ ->
  return unless $('#task-list')[0]
  Vue.use @['vue-validator']
  projectId = $('#task-list').data 'project-id'
  taskListView = app.TaskListView '#task-list', projectId
  app.TaskFormView '#task-form', projectId, taskListView
