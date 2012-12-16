define ['jquery','cs!umobi.core'], () ->
  c = window.applicationCache
  switch (c.status) {
    when c.UNCACHED then # UNCACHED == 0
      return 'UNCACHED'
    when c.IDLE then # IDLE == 1
      return 'IDLE'
    when c.CHECKING then # CHECKING == 2
      return 'CHECKING'
    when c.DOWNLOADING then # DOWNLOADING == 3
      return 'DOWNLOADING'
    when c.UPDATEREADY then  # UPDATEREADY == 4
      return 'UPDATEREADY'
    when c.OBSOLETE then # OBSOLETE == 5
      return 'OBSOLETE'
    else
      return 'UKNOWN CACHE STATUS'
