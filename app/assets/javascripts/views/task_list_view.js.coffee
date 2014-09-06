app = @app

app.TaskListView = (el, projectId) ->
  new Vue
    el: el
    created: ->
      @tasks = []
      $.ajax
        type: 'get'
        url: '/api/tasks'
        data:
          project_id: projectId
        success: (data) =>
          @tasks = data

      $(@$el).sortable
        start: (e, ui) ->
          ui.item.data 'start', ui.item.index()
        update: (e, ui) =>
          start = ui.item.data 'start'
          end = ui.item.index()
          $.ajax
            type: 'put'
            url: "/api/tasks/#{@tasks[start].uuid}/position"
            data:
              project_id: projectId
              position: end + 1
          @tasks.splice end, 0, @tasks.splice(start, 1)[0]

    methods:
      destroy: (task) ->
        @tasks.$remove task.$data
        $.ajax
          type: 'delete'
          url: "/api/tasks/#{task.uuid}"
          data:
            project_id: projectId

      updateStatus: (task) ->
        task.status = switch task.status
                        when 'unstarted' then 'started'
                        when 'started'   then 'finished'
        $.ajax
          type: 'put'
          url: "/api/tasks/#{task.uuid}"
          data:
            project_id: projectId
            task:
              status: task.status

      editAttributes: ->
        ['task_type', 'point', 'status', 'title', 'description']

      save: (task) ->
        task.isEdit = false
        $.ajax
          type: 'put'
          url: "/api/tasks/#{task.uuid}"
          data:
            project_id: projectId
            task:
              task_type: task.task_type
              point: task.point
              status: task.status
              title: task.title
              description: task.description

      edit: (task) ->
        task.form = {}
        for attr in @editAttributes()
          task.form[attr] = task[attr]
        task.isEdit = !task.isEdit

      close: (task) ->
        task.isEdit = false
        for attr in @editAttributes()
          task[attr] = task.form[attr]

