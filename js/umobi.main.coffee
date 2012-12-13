
define [
  "jquery"
  "cs!umobi.core"
  "umobi.dom"
  "cs!umobi.page"
  "cs!umobi.widget"
  "cs!umobi.zoom"
  "cs!umobi.navigation"
], ($, umobi)->
  # Page Initialization
  $html = $(document.getElementsByTagName('html')[0])
  $ ->
    $(document).trigger('pageinit')

    defaultHomeScroll = if not $.support.scrollTop or $( window ).scrollTop() is 1 then 0 else 1

    # find static pages and initialize them
    $pages = $('[data-role="page"]')

		# if no pages are found, create one with body's inner html
    if not $pages.length
      $pages = $( "body" ).wrapInner( "<div data-role=\"page\"></div>" ).children( 0 )
    else
      $pages.each ->
        $(this).trigger('pagecreate',[this])
        umobi.page.initPage(this)

    if location.hash
      umobi.page.showPageByHash(location.hash)
    else
      umobi.page.showPage($pages.first())

    $(document.links).each (i,e) ->
      $a = $(this)
      $a.addClass('ui-link')
      $a.click (e) ->
        href = $(this).attr('href')
        if href.match(/^#\w+/)
          umobi.page.showPageByHash(href)

    $html.removeClass('ui-mobile-rendering')
