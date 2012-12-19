###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define [
  "cs!umobi.core"
  "cs!u"
  "cs!umobi.page"
  ], ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    u.ready () ->
      for link in document.links
        u(link).addClass('ui-link').click (e) ->
          href = u(this).attr('href')
          if href.match( /^#\w+/ )
            umobi.page.revealByHash(href)
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
