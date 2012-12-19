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
    btnUpClass = "ui-btn-up-#{ umobi.config.theme }"
    btnDownClass = "ui-btn-down-#{ umobi.config.theme }"
    btnHoverClass = "ui-btn-hover-#{ umobi.config.theme }"
    $el.hover ((e) ->
      u(this).removeClass(btnUpClass).addClass(btnHoverClass)
    ), ((e) ->
      u(this).removeClass(btnHoverClass).addClass(btnUpClass)
    )
    $el.on 'mousedown', (e) ->
      u(this).removeClass(btnHoverClass).removeClass(btnUpClass).addClass(btnDownClass)
    $el.on 'mouseup', (e) ->
      u(this).removeClass(btnDownClass).addClass(btnHoverClass)

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
