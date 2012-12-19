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
    initializeLinks = () ->
      for link in document.links
        ulink = u(link)

        # TODO: let's refactor this to button markup js file.
        if ulink.data("role") is "button"
          ulink.data("corners",true)
            .data("shadow",true)
            .data("theme",umobi.config.theme)
          ulink.addClass(["ui-btn","ui-shadow","ui-btn-corner-all","ui-btn-up-#{ umobi.config.theme }"])
          ulink.addClass("ui-mini") if ulink.data 'mini'
          # initialize <a> as a button
          $(link).wrapInner("""
            <span class="ui-btn ui-btn-corner-all">
              <span class="ui-btn-text">
              </span>
            </span>
          """)
        else
          # initialize <a> as a normal link
          ulink.addClass('ui-link').click (e) ->
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
