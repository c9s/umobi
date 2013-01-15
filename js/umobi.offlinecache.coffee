define ['cs!umobi.core','cs!u'], () ->
  (->
    c = window.applicationCache
    switch c.status
      # UNCACHED == 0
      when c.UNCACHED
        return 'UNCACHED'
      when c.IDLE # IDLE == 1
        return 'IDLE'
      when c.CHECKING # CHECKING == 2
        return 'CHECKING'
      when c.DOWNLOADING # DOWNLOADING == 3
        return 'DOWNLOADING'
      when c.UPDATEREADY  # UPDATEREADY == 4
        return 'UPDATEREADY'
      when c.OBSOLETE # OBSOLETE == 5
        return 'OBSOLETE'
      else
        return 'UKNOWN CACHE STATUS'
  )
  return
