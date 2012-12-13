define ["jquery","umobi.dom"], ($,dom) ->
  $ ->
    inputs = dom.queryAll('input')
    for input in inputs
      if input.type is "text" or input.type is "password"
        uiClass = "ui-input-text"
        input.className += uiClass
        $input = $(input)
        $input.wrap('<div class="' + uiClass + ' ui-shadow-inset ui-corner-all ui-btn-shadow"></div>')
        $input.focus () -> $(this).parent().addClass('ui-focus')
        $input.blur () -> $(this).parent().removeClass('ui-focus')
