(->
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
      if window.navigator.userAgent.match(/iPhone|iPad|Android/)
        d = document
        hideAddressBar = ->
          if d.documentElement.scrollHeight < (window.outerHeight / window.devicePixelRatio)
            d.documentElement.style.height = (window.outerHeight / window.devicePixelRatio) + 'px'
          window.scrollTo(0,1)
          # window.top.scrollTo(0,1)
        window.addEventListener "load",hideAddressBar
        window.addEventListener "orientationchange",hideAddressBar
        $(d).on 'pagereveal', hideAddressBar

    u.load -> uhtml.removeClass('ui-mobile-rendering')
    u(document.body).addClass("ui-body-c")
)()
