app = @app

app.TaskListView = (el) ->
  new Vue
    el: el
    created: ->
      @tasks = app.SampleData
      $(@$el).sortable
        start: (e, ui) ->
          ui.item.data 'start', ui.item.index()
        update: (e, ui) =>
          start = ui.item.data 'start'
          end = ui.item.index()
          @tasks.splice end, 0, @tasks.splice(start, 1)[0]
    methods:
      destroy: (task) ->
        @tasks.$remove task.$data
      updateStatus: (task) ->
        task.status = switch task.status
                        when 'unstarted' then 'started'
                        when 'started'   then 'finished'
      save: (form, task) ->
        for attr of form
          task.$data[attr] = form[attr]

      edit: (form, task) ->
        for attr of task.$data
          form[attr] = task.$data[attr]
        task.isEdit = !task.isEdit
