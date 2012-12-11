define ["jquery","umobi.dom"], ($,dom) ->
  $ ->
    inputs = dom.queryAll('input')
    for input in inputs
      input.className += "ui-input-" + input.type
      $(input).wrap('<div class=""></div>')
