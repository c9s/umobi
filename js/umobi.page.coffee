define ["cs!umobi.core"], ->

  umobi.showPage = (hash) ->
    # hide current active page
    $('.ui-page-active').removeClass('ui-page-active')


    # show first page if page not found.
    $page = $(hash)
    if $page.get(0)
      $page.addClass('ui-page-active')
    else
      $($('[data-role="page"]').get(0)).addClass('ui-page-active')

  # umobi
  umobi.initPageContainer = (el) ->
    $el = $(el)
    $el.addClass('ui-page')
    $h = $el.find('[data-role="header"]').addClass('ui-hd') # header container
    $f = $el.find('[data-role="footer"]').addClass('ui-ft')  # footer container
    $c = $el.find('[data-role="content"]').addClass('ui-content') # content container

    $h.find('h1,h2,h3,h4,h5,h6').addClass('ui-title')

    isFixed = $h.data 'fixed' or $f.data 'fixed'

    headerHeight = $h.height()
    footerHeight = $f.height()

    if isFixed
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
      AdjustContentHeight()

      resizeTimeout = null
      $(window).resize ->
        clearTimeout(resizeTimeout) if resizeTimeout
        resizeTimeout = setTimeout AdjustContentHeight, 1000

    $h.addClass('ui-fixed-hd') if $h.data 'fixed'
    $f.addClass('ui-fixed-ft') if $f.data 'fixed'
