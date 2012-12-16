####
# umobi mobile web framework
####
define ["depend!jquery.hashchange[jquery]"], () ->
  umobi =
    Env: { }
  window.umobi = umobi
  return umobi
