define [
  "jquery",
  "cs!umobi.core"
  "cs!umobi.navigation"
], ($, uMobi)->
  # Page Initialization
  $ ->
    $(document).trigger('pageinit')

    # find static pages and initialize them
    $pages = $('[data-role="page"]')
    $pages.each ->
      $(this).trigger('pagecreate',[this])
      uMobi.initPageContainer(this)
    $pages.hide()
    $pages.first().show().addClass('ui-page-active')

    $(document.links).each (i,e) ->
      $a = $(this)
      $a.addClass('ui-link')
      $a.click (e) ->
        href = $(this).attr('href')
        if href.match(/^#\w+/)
          uMobi.showPage(href)
