###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['cs!u.dom','cs!u','cs!umobi.core'], (dom,u,umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  $ ->
    buttons = u.dom.queryAll('[data-role="button"]')
    for button in buttons
      $(button)
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
