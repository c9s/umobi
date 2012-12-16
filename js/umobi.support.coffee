define ['cs!umobi.core'] , (umobi) ->
  umobi.support = {
    offlineCache: typeof window.applicationCache isnt 'undefined'
    classList: typeof document.documentElement isnt 'undefined'
  }
  umobi.support
