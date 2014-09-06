app = @app

app.TaskFormView = (el, projectId, taskListView) ->
  new Vue
    el: el
    created: (value) ->
      @isNew = true
    methods:
      save: (form) ->
        task = $.extend {uuid: uuid.v4()}, form
        taskListView.tasks.push task
        @close form
        $.ajax
          type: 'post'
          url: '/api/tasks'
          data:
            project_id: projectId
            task: task

      close: (form) ->
        @form =
          task_type: 'feature'
          point: 0
          status: 'unstarted'
          title: null
          description: null
