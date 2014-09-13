# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  return unless $('#task-list')[0]
  Vue.use @['vue-validator']
  projectId = $('#task-list').data 'project-id'
  createTaskListView = require 'views/task_list_view'
  createTaskFormView = require 'views/task_form_view'
  taskListView = createTaskListView '#task-list', projectId
  createTaskFormView '#task-form', projectId, taskListView
