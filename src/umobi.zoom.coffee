meta = $("meta[name=viewport]")
initialContent = meta.attr( "content" )
disabledZoom = initialContent + ",maximum-scale=1, user-scalable=no"
enabledZoom = initialContent + ",maximum-scale=10, user-scalable=yes"
disabledInitially = /(user-scalable[\s]*=[\s]*no)|(maximum-scale[\s]*=[\s]*1)[$,\s]/.test( initialContent )
umobi.zoom = $.extend {},
  enabled: (not disabledInitially)
  locked: false
  disable: (lock) ->
    if not disabledInitially and not umobi.zoom.locked
      meta.attr( "content", disabledZoom )
      umobi.zoom.enabled = false
      umobi.zoom.locked = lock or false
  enable: (unlock) ->
    if not disabledInitially and ( not umobi.zoom.locked or unlock isnt true )
      meta.attr( "content", enabledZoom )
      umobi.zoom.enabled = true
      umobi.zoom.locked = false
  restore: ->
    if not disabledInitially
      meta.attr( "content", initialContent )
      umobi.zoom.enabled = true
