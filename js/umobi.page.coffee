define ["cs!umobi.core"], ->

  umobi.showPage = ($page) ->
    # hide current active page
    $('.ui-page-active').removeClass('ui-page-active')
    $page.addClass('ui-page-active')
    $page.trigger('pagereveal')

  umobi.showPageByHash = (hash) ->
    # show first page if page not found.
    $page = $(hash)
    $page = $('[data-role="page"]').first() if not $page.get(0)
    umobi.showPage($page)

  # umobi
  umobi.initPageContainer = (el) ->
    $page = $(el)
    $page.addClass('ui-page ui-body-c')
    $h = $page.find('[data-role="header"]').addClass('ui-hd') # header container
    $f = $page.find('[data-role="footer"]').addClass('ui-ft')  # footer container
    $c = $page.find('[data-role="content"]').addClass('ui-content') # content container

    $h.find('h1,h2,h3,h4,h5,h6').addClass('ui-title')

    isBothFixed = $h.data 'fixed' or $f.data 'fixed'

    if isBothFixed
      AdjustContentHeight = ->
        contentHeight = $(window).height()
        contentTop    = 0
        contentBottom = 0
        $c.addClass('ui-fixed-content')
        if $h.get(0)
          contentTop = $h.height()
        if $f.get(0)
          contentBottom = $f.height()
        $c.css
          position: 'fixed'
          top: contentTop + 'px'
          left: 0
          bottom: contentBottom + 'px'
          overflow: 'auto'
      $page.on 'pagereveal', AdjustContentHeight


      resizeTimeout = null
      $(window).resize ->
        clearTimeout(resizeTimeout) if resizeTimeout
        resizeTimeout = setTimeout AdjustContentHeight, 1000

    $h.addClass('ui-fixed-hd') if $h.data 'fixed'
    $f.addClass('ui-fixed-ft') if $f.data 'fixed'
