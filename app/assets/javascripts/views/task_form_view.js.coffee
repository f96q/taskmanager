app = @app

app.TaskFormView = (el, projectId, taskListView) ->
  new Vue
    el: el
    data:
      task_type: 'feature'
      point: 0
      status: 'unstarted'
      title: ''
      description: ''
    methods:
      save: ->
        task =
          uuid: uuid.v4()
          task_type: @task_type
          point: @point
          status: @status
          title: @title
          description: @description
        taskListView.tasks.push task
        @close()
        $.ajax
          type: 'post'
          url: '/api/tasks'
          data:
            project_id: projectId
            task: task
      close: ->
        @task_type = 'feature'
        @point = 0
        @status = 'unstarted'
        @title = ''
        @description = ''
