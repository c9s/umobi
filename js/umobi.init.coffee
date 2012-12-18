###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define [
  "cs!umobi.core"
  "cs!u"
  "cs!umobi.page"
  "cs!umobi.widget"
  "cs!umobi.zoom"
  "cs!umobi.listview"
  "cs!umobi.navigation" ], () ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    # Page Initialization
    uhtml = u('html')
    uhtml.children(0).addClass(['ui-mobile','ui-mobile-rendering'])

    u.ready ->
      $(document).trigger('pageinit')

      # defaultHomeScroll = if not $.support.scrollTop or $( window ).scrollTop() is 1 then 0 else 1

      # find static pages and initialize them
      $pages = umobi.page.all()

      # if no pages are found, create one with body's inner html
      if not $pages.length
        $pages = $("body").wrapInner( "<div data-role=\"page\"></div>" ).children(0)
      $pages.each -> umobi.page.create(this)

      for link in document.links
        $(link).addClass('ui-link').click (e) ->
          href = $(this).attr('href')
          if href.match(/^#\w+/)
            umobi.page.revealByHash(href)

      # currently, if the page can not be scrolled, this won't work.
      if window.navigator.userAgent.match(/iPhone|iPad|Android/)
        hideAddressBar = () ->
          if document.documentElement.scrollHeight < (window.outerHeight / window.devicePixelRatio)
            document.documentElement.style.height = (window.outerHeight / window.devicePixelRatio) + 'px'
            # TODO: move this to structure css?
            document.documentElement.style.overflow = 'hidden'
          window.scrollTo(0,1)
          # window.top.scrollTo(0,1)
        window.addEventListener("load",hideAddressBar)
        window.addEventListener("orientationchange",hideAddressBar)
        $(document).on('pagereveal', hideAddressBar )

      if location.hash
        umobi.page.revealByHash(location.hash)
      else
        indexPage = u.dom.query('#index')
        if indexPage
          umobi.page.reveal($(indexPage))
        else
          umobi.page.reveal($pages.first())

      u.load -> uhtml.removeClass('ui-mobile-rendering')
  )()

  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
