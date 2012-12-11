define ["jquery","umobi.dom"], ($,dom) ->
  $ ->
    inputs = dom.queryAll('input')
    for input in inputs
      if input.type is "text" or input.type is "password"
        uiClass = "ui-input-" + input.type
        input.className += "ui-input-" + uiClass
        $(input).wrap('<div class="' + uiClass + ' ui-shadow-inset ui-corner-all ui-btn-shadow"></div>')
