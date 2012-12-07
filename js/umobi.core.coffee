####
# uMobi framework
####
uMobi =
  Env: { }

# uMobi
uMobi.initPageContainer = (el) ->
  $el = $(el)
  $el.addClass('ui-page')
  $h = $el.find('[data-role="header"]').addClass('ui-hd') # header container
  $f = $el.find('[data-role="footer"]').addClass('ui-ft')  # footer container
  $c = $el.find('[data-role="content"]').addClass('ui-content') # content container

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

$ ->
  $(document).trigger('pageinit')

  # find static pages and initialize them
  $pages = $('[data-role="page"]')
  $pages.each ->
    $(this).trigger('pagecreate',[this])
    uMobi.initPageContainer(this)
