define ['jquery','cs!umobi.core'], () ->
  appCache = window.applicationCache
  switch (appCache.status) {
    when appCache.UNCACHED then # UNCACHED == 0
      return 'UNCACHED'
    when appCache.IDLE then # IDLE == 1
      return 'IDLE'
    when appCache.CHECKING then # CHECKING == 2
      return 'CHECKING'
    when appCache.DOWNLOADING then # DOWNLOADING == 3
      return 'DOWNLOADING'
    when appCache.UPDATEREADY then  # UPDATEREADY == 4
      return 'UPDATEREADY'
    when appCache.OBSOLETE then # OBSOLETE == 5
      return 'OBSOLETE'
    else
      return 'UKNOWN CACHE STATUS'
