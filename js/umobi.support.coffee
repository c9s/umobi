# Reference: http://www.html5rocks.com/en/tutorials/appcache/beginner/
define ['cs!umobi.core'] , ->
  support = {
    offlineCache: (typeof window.applicationCache isnt 'undefined')
    classList: (typeof document.documentElement isnt 'undefined')
    touch: (navigator.userAgent.match /(iPhone|iPad|Android|Mobile)/)
  }
  support.matrix = `"WebKitCSSMatrix" in window`

  # with m11 3d translate
  support.matrixM11  = support.matrix and ("m11" in new WebKitCSSMatrix())
  umobi.support = support
  return umobi.support
