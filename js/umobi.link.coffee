###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define [
  "cs!str"
  "cs!umobi.core"
  "cs!u"
  "cs!umobi.page"
  "cs!umobi.button"
], ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  
  ###
  To inner wrap a link with ui-btn classes:

  <a href="index.html" data-role="button" data-corners="true"
    data-shadow="true" data-iconshadow="true" data-wrapperels="span"
    data-theme="c" class="ui-btn ui-shadow ui-btn-corner-all ui-btn-up-c">
      <span class="ui-btn-inner ui-btn-corner-all">
        <span class="ui-btn-text">Link button</span>
      </span>
  </a>
  ###
  (->
    initializeLinks = ->
      for link in document.links
        ulink = u(link)
        if not ulink.data('role')
          # initialize <a> as a normal link
          ulink.addClass('ui-link')
        ulink.click (e) ->
          href = ulink.attr('href')
          umobi.page.revealByHash(href) if href.match( /^#\w+/ )
    u.ready initializeLinks
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
