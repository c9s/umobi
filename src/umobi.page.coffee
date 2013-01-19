#  define [
#    "cs!umobi.core"
#    "cs!u"
#    "cs!umobi.scroller"
#    "cs!umobi.support"
#  ], () ->


# prevent body scrolling
u('body').css('overflow','hidden').addClass('ui-overlay-c')

# static methods of page object.
umobi.page =

  # get all pages
  findAll: -> u('[data-role="page"],page')

  # get active page
  findActive: -> u('.ui-page-active')

  init: ->
    $(document).trigger('pageinit')

    # find static pages and initialize them
    pages = @findAll()
    # if no pages are found, create one with body's inner html
    if not pages.get(0)
      pages = u($("body").wrapInner( "<div data-role=\"page\"></div>" ).children(0).get(0))
    pages.each (i,e) => @create(e)

    if location.hash
      @revealByHash(location.hash)
    else
      indexPage = u('#index')
      if indexPage.get(0)
        @reveal(indexPage)
      else
        @reveal(pages.first())

  # $p: page element object.
  reveal: (p) ->
    # hide current active page
    @findActive().removeClass("ui-page-active")
    p.addClass("ui-page-active").trigger("pagereveal")
    $(document).trigger("pagereveal",[p])

  # reveal page element by hash
  revealByHash: (hash) ->
    # show first page if page not found.
    upage = u(hash)
    if not upage.get(0)
      upage = u('[data-role="page"]').first()
    umobi.page.reveal(upage)

  create: (el) ->
    upage = u(el).addClass(["ui-page","ui-body-#{ umobi.config.theme }"])

    # trigger pagecreate event.
    upage.trigger("pagecreate")

    h = upage.find('[data-role="header"],header').addClass("ui-header") # header container
    f = upage.find('[data-role="footer"],footer').addClass("ui-footer")  # footer container
    c = upage.find('[data-role="content"]').addClass("ui-content") # content container

    h.find("h1,h2,h3,h4,h5,h6").addClass("ui-title")
    isBothFixed = h.data "fixed" or f.data "fixed"

    # TODO: iOS5.0+, Android 2.2 supports position:fixed,
    # we need a simple detection here.
    #
    # and there is a native scrolling support in iOS5
    #
    #    -webkit-overflow-scrolling: touch;
    #
    if isBothFixed
      $c = c.jQuery()

      # create ui-content container for scrolling
      $c.wrap('<div class="ui-content-container"/>')
      $contentContainer = $c.parent()

      # Initialize touch scroller with 3D translate if it's on mobile
      # device and the touchScroll option is enabled.
      if umobi.support.touch and umobi.config.touchScroll
        # create js touch scroller for content wrapper.
        umobi.scroller.create(c.get(0))
        document.documentElement.style.overflow = "hidden"
        $contentContainer.addClass "ui-content-scroll"

      # if touchScroll option is not enabled, we should just
      # adjust cotnent padding to keep space for header and footer.
      if not umobi.config.touchScroll
        AdjustContentPadding = ->
          # console.log "pagereveal", h.height(), f.height()
          $contentContainer.css({
            "position": "absolute"
            "-webkit-overflow-scrolling": "touch"
            "overflow": "auto"
          })
          $contentContainer.css("top", h.height() + "px") if h.get(0)
          $contentContainer.css("bottom", f.height() + "px") if f.get(0)
        upage.on "pagereveal", AdjustContentPadding
      else
        # use absolute position and fixed header/footer for desktop
        AdjustContentHeight = (e) ->
          # console.log "pagereveal" , h.height(), f.height()
          contentHeight = $(window).height()
          contentTop    = if h.get(0) then h.height() else 0
          contentBottom = if f.get(0) then f.height() else 0
          $contentContainer.css
            position: "absolute"
            top: contentTop + "px"
            left: 0
            bottom: contentBottom + "px"
            overflow: if umobi.support.touch then "hidden" else "auto"
        upage.on "pagereveal", AdjustContentHeight

    resizeTimeout = null
    u(window).on "resize", ->
      clearTimeout(resizeTimeout) if resizeTimeout
      resizeTimeout = setTimeout AdjustContentHeight, 100
    h.addClass("ui-fixed-header") if h.attr "data-fixed"
    f.addClass("ui-fixed-footer") if f.attr "data-fixed"
