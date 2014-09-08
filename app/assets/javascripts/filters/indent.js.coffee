Vue.filter 'indent', (text) ->
  text.replace /\r\n|\r|\n/g, '<br />'
