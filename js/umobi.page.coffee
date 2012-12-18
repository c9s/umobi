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
        upage = u(el)
        upage.trigger('pagecreate').addClass(['ui-page','ui-body-c'])

        # TODO: rewrite this with umobi.dom
        h = upage.find('[data-role="header"]').addClass('ui-header') # header container
        f = upage.find('[data-role="footer"]').addClass('ui-footer')  # footer container
        c = upage.find('[data-role="content"]').addClass('ui-content') # content container

        h.find('h1,h2,h3,h4,h5,h6').addClass('ui-title')
        isBothFixed = h.attr 'data-fixed' or f.attr 'data-fixed'

        if isBothFixed
          $c = c.jQuery()
          $c.wrap('<div class="ui-content-scroll"/>')
          $scrollingContent = $c.parent()
          umobi.scroller.create(c.get(0))
          AdjustContentHeight = (e) ->
            contentHeight = $(window).height()
            contentTop    = 0
            contentBottom = 0
            contentTop    = h.height() if h.get(0)
            contentBottom = f.height() if f.get(0)
            $scrollingContent.css
              position: 'absolute'
              top: contentTop + 'px'
              left: 0
              bottom: contentBottom + 'px'
              overflow: 'auto'

          $page.on 'pagereveal', AdjustContentHeight
        resizeTimeout = null
        u(window).on 'resize',->
          clearTimeout(resizeTimeout) if resizeTimeout
          resizeTimeout = setTimeout AdjustContentHeight, 100
        h.addClass('ui-fixed-header') if h.attr 'data-fixed'
        f.addClass('ui-fixed-footer') if f.attr 'data-fixed'
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
