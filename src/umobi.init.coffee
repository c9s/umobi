( (w,d)->
  # To optimize rendering performance, we append a ui-mobile-rendering class
  # to hide elements before rendering pages and adding classes to every
  # elements.
  uhtml = u('html')
  uhtml.children(0).addClass(['ui-mobile','ui-mobile-rendering'])
  u.ready ->
    # defaultHomeScroll = if not $.support.scrollTop or $( window ).scrollTop() is 1 then 0 else 1


    if umobi.config.enablePage
      umobi.page.init()
      # currently, if the page can not be scrolled, this won't work.
      if w.navigator.userAgent.match(/iPhone|iPad|Android/)
        hideAddressBar = ->
          if d.documentElement.scrollHeight < (w.outerHeight / w.devicePixelRatio)
            d.documentElement.style.height = (w.outerHeight / w.devicePixelRatio) + 'px'
          w.scrollTo(0,1)
          # window.top.scrollTo(0,1)
        w.addEventListener "load",hideAddressBar
        w.addEventListener "orientationchange",hideAddressBar
        $(d).on 'pagereveal', hideAddressBar
    u.load -> uhtml.removeClass('ui-mobile-rendering')
    u(d.body).addClass("ui-body-c")
)(window,document)
