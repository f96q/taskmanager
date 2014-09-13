createTaskListView = (el, projectId) ->
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
          $.map data, (task) =>
            task.passedTime = @calcPassedTime task
            @tasks.push task

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
        params = {}
        switch task.status
          when 'unstarted'
            task.status = 'started'
            task.started_at = new Date().toUTCString()
            params = {status: task.status, started_at: task.started_at}
          when 'started'
            task.status = 'finished'
            task.finished_at = new Date().toUTCString()
            task.passedTime = @calcPassedTime task
            params = {status: task.status, finished_at: task.finished_at}
        $.ajax
          type: 'put'
          url: "/api/tasks/#{task.uuid}"
          data:
            project_id: projectId
            task: params

      calcPassedTime: (task) ->
        return unless task.started_at? and task.finished_at?
        sec = (new Date(task.finished_at).getTime() - new Date(task.started_at).getTime()) / 1000
        hour = Math.floor sec / 3600
        min  = Math.floor (sec - hour * 3600) / 60
        "#{if hour < 10 then '0' + hour else hour}:#{if min < 10 then '0' + min else min}"

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

module.exports = createTaskListView
