# Reference: http://www.html5rocks.com/en/tutorials/appcache/beginner/
###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['cs!umobi.core'] , (umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  umobi.support = {
    offlineCache: (typeof window.applicationCache isnt 'undefined')
    classList: (typeof document.documentElement isnt 'undefined')
    touchEnabled: (navigator.userAgent.match /(iPhone|iPad|Android|Mobile)/)
  }
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)`
  ###
  return umobi.support
###
//>>excludeEnd("umobiBuildExclude")
###
