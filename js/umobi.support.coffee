# Reference: http://www.html5rocks.com/en/tutorials/appcache/beginner/
###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['cs!umobi.core'] , ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  support = {
    offlineCache: (typeof window.applicationCache isnt 'undefined')
    classList: (typeof document.documentElement isnt 'undefined')
    touchEnabled: (navigator.userAgent.match /(iPhone|iPad|Android|Mobile)/)
  }
  support.matrix = `"WebKitCSSMatrix" in window`
  # with m11 3d translate
  support.matrixM11  = umobi.support.matrix and ("m11" in new WebKitCSSMatrix())
  umobi.support = support
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)`
  ###
  return umobi.support
###
//>>excludeEnd("umobiBuildExclude")
###
