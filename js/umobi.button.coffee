###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!umobi.core'], ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  $ ->
    buttons = umobi.dom.queryAll('[data-role="button"]')
    for button in buttons
      $(button)
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
