####
# uMobi framework
####
define ["depend!jquery.hashchange[jquery]"], () ->
  uMobi =
    Env: { }

  window.uMobi = uMobi

  uMobi.showPage = (hash) ->
    # hide current active page
    $('.ui-page-active').hide().removeClass('ui-page-active')

    # show first page if page not found.
    $page = $(hash)
    if $page.get(0)
      $page.show().addClass('ui-page-active')
    else
      $($('[data-role="page"]').get(0)).show().addClass('ui-page-active')

  uMobi.handleHashChange = (e) ->
    hash = location.hash
    uMobi.showPage(hash)

  # uMobi
  uMobi.initPageContainer = (el) ->
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
  return uMobi
