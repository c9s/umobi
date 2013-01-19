# define ["jquery","cs!umobi.core","cs!u"], () ->
u.ready ->
  inputs = u('input[type="text"],input[type="password"]')
  for input in inputs.all()
    $input = $(input)
    uiClass = "ui-input-text"
    input.className += uiClass
    $input.wrap('<div class="' + uiClass + ' ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c"></div>')
    $input.focus -> $(this).parent().addClass('ui-focus')
    $input.blur -> $(this).parent().removeClass('ui-focus')
    $input.parent().addClass("ui-mini") if $input.data("mini")

  textareas = u('textarea')
  for input in textareas.all()
    input.className += "ui-input-text ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c"
    $input.focus -> $(this).addClass('ui-focus')
    $input.blur -> $(this).removeClass('ui-focus')
    $input.parent().addClass("ui-mini") if $input.data("mini")
#        $input.on 'touchmove', (e) ->
#          e.stopPropagation()
#          e.stopImmediatePropagation()
#        $input.on 'touchstart', (e) ->
#          e.stopPropagation()
#          e.stopImmediatePropagation()
