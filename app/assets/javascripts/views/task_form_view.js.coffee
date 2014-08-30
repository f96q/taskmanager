app = @app

app.TaskFormView = (el, taskListView) ->
  new Vue
    el: el
    created: (value) ->
      @isNew = true
    methods:
      save: (form) ->
        task = $.extend {},form
        taskListView.tasks.push task
        @close form

      close: (form) ->
        @form =
          task_type: 'feature'
          point: 0
          status: 'unstarted'
          title: null
          description: null
