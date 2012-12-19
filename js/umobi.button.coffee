###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!u.dom','cs!u','cs!umobi.core'], ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  umobi.button = { }
  umobi.button.markup = (el) ->

  umobi.button.bindClassEvents = (el) ->
    $el = $(el)
    # class name map hash
    theme = umobi.config.theme
    cmap =
      up:    "ui-btn-up-#{theme}"
      down:  "ui-btn-down-#{theme}"
      hover: "ui-btn-hover-#{theme}"
    $el.addClass cmap.up
    $el.hover (->
      u(@).removeClass(cmap.up).addClass(cmap.hover)
    ), (->
      u(@).removeClass(cmap.hover).addClass(cmap.up)
    )
    $el.on 'mousedown',->
      u(@).removeClass(cmap.hover).removeClass(cmap.up).addClass(cmap.down)
    $el.on 'mouseup',->
      u(@).removeClass(cmap.down).addClass(cmap.hover)

  u.ready ->
    buttons = u.dom.queryAll('[data-role="button"]')
    # for button in buttons
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
