# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = @app

$ ->
 return unless $('#task-list')[0]
 taskListView = app.TaskListView '#task-list'
 app.TaskFormView '#task-form', taskListView
