define ["cs!umobi.core"], ->

  umobi.showPage = ($page) ->
    # hide current active page
    $('.ui-page-active').removeClass('ui-page-active')
    $page.addClass('ui-page-active').trigger('pagereveal')

  umobi.showPageByHash = (hash) ->
    # show first page if page not found.
    $page = $(hash)
    $page = $($('[data-role="page"]').get(0)) if not $page.get(0)
    umobi.showPage($page)

  # umobi
  umobi.initPageContainer = (el) ->
    $page = $(el)
    $page.addClass('ui-page ui-body-c')
    $h = $page.find('[data-role="header"]').addClass('ui-header') # header container
    $f = $page.find('[data-role="footer"]').addClass('ui-footer')  # footer container
    $c = $page.find('[data-role="content"]').addClass('ui-content') # content container

    $h.find('h1,h2,h3,h4,h5,h6').addClass('ui-title')

    isBothFixed = $h.data 'fixed' or $f.data 'fixed'

    if isBothFixed
      $c.wrap('<div class="ui-content-scroll"/>')
      AdjustContentHeight = ->
        contentHeight = $(window).height()
        contentTop    = 0
        contentBottom = 0
        if $h.get(0)
          contentTop = $h.height()
        if $f.get(0)
          contentBottom = $f.height()

        $c.parent().css
          position: 'fixed'
          top: contentTop + 'px'
          left: 0
          bottom: contentBottom + 'px'
          overflow: 'auto'
        window.scrollTo(0,1)
      $page.on 'pagereveal', AdjustContentHeight
    else
      $page.on 'pagereveal', -> window.scrollTo(0, 1)

    resizeTimeout = null
    $(window).resize ->
      clearTimeout(resizeTimeout) if resizeTimeout
      resizeTimeout = setTimeout AdjustContentHeight, 1000

    $h.addClass('ui-fixed-header') if $h.data 'fixed'
    $f.addClass('ui-fixed-footer') if $f.data 'fixed'
