###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define [
  "cs!umobi.core"
  "cs!u"
  "cs!umobi.scroller"
], (umobi,u) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    # prevent body scrolling
    u('body').css('overflow','hidden').addClass('ui-overlay-c')

    # static methods of page object.
    umobi.page =

      # get all pages
      all: -> $(u.dom.queryAll('[data-role="page"]'))

      # get active page
      active: () -> $(u.dom.queryAll('.ui-page-active'))

      # $p: page element object.
      reveal: ($p) ->
        # hide current active page
        @active().removeClass('ui-page-active')
        $p.addClass('ui-page-active').trigger('pagereveal')
        $(document).trigger('pagereveal',[$p])

      # reveal page element by hash
      revealByHash: (hash) ->
        # show first page if page not found.
        $page = $(hash)
        $page = $('[data-role="page"]').first() if not $page.get(0)
        umobi.page.reveal($page)

      create: (el) ->
        $page = $(el)
        $page.trigger('pagecreate').addClass('ui-page ui-body-c')

        # TODO: rewrite this with umobi.dom
        $h = $page.find('[data-role="header"]').addClass('ui-header') # header container
        $f = $page.find('[data-role="footer"]').addClass('ui-footer')  # footer container
        $c = $page.find('[data-role="content"]').addClass('ui-content') # content container

        $h.find('h1,h2,h3,h4,h5,h6').addClass('ui-title')

        isBothFixed = $h.data 'fixed' or $f.data 'fixed'

        if isBothFixed
          $c.wrap('<div class="ui-content-scroll"/>')
          $scrollingContent = $c.parent()

          scroller = umobi.scroller.create($c.get(0))

          AdjustContentHeight = (e) ->
            $content = $page.find('[data-role="content"]')
            $header = $page.find('[data-role="header"]')
            $footer = $page.find('[data-role="footer"]')
            contentHeight = $(window).height()
            contentTop    = 0
            contentBottom = 0
            if $header.get(0)
              contentTop = $header.height()
            if $footer.get(0)
              contentBottom = $footer.height()

            $scrollingContent.css
              position: 'absolute'
              top: contentTop + 'px'
              left: 0
              bottom: contentBottom + 'px'
              overflow: 'auto'

          $page.on 'pagereveal', AdjustContentHeight

        resizeTimeout = null
        $(window).resize ->
          clearTimeout(resizeTimeout) if resizeTimeout
          resizeTimeout = setTimeout AdjustContentHeight, 100

        $h.addClass('ui-fixed-header') if $h.data 'fixed'
        $f.addClass('ui-fixed-footer') if $f.data 'fixed'
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
