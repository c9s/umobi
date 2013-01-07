
define [
  "cs!u"
  "cs!umobi.core"
  "cs!umobi.page"
], ->

  umobi.splitview =
    init: () ->
      for view in u('[data-role="splitview"]').all()
        umobi.splitview.create(view)

    create: (view) ->
      contentPrimary = u(view).findone('[data-role="content-primary"]')
      contentSecondary = u(view).findone('[data-role="content-secondary"]')

      # asideWidth = parseInt($(window).width() * 0.20) + "px"
      asideWidth = "230px"

      contentSecondary.css {
        position: "absolute"
        top: 0
        left: 0
        height: "100%"
        width: asideWidth
      }

      contentPrimary.css {
        position: "relative"
        left: "0px"
        top: "0px"
        marginLeft: asideWidth
      }
      # we should use the same logic in page.
      # scale the content containers to let the content scroll works
      # because the overflow-scroll attribute only works for webkit-based browser.
  u.ready -> umobi.splitview.init()
