Vue.filter 'status', (value) ->
  switch value
    when 'unstarted' then 'start'
    when 'started'   then 'finish'
    when 'finished'  then 'finish'
