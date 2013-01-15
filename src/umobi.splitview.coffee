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
      contentSecondary.addClass("ui-content-secondary")
      contentPrimary.addClass("ui-content-primary")

      # we should use the same logic in page.
      # scale the content containers to let the content scroll works
      # because the overflow-scroll attribute only works for webkit-based browser.
  u.ready -> umobi.splitview.init()
