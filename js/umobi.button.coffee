###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!umobi.core','cs!u'], ->
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
