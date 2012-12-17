###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['cs!u','cs!umobi.core'], (u,umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  $ ->
    listviews = u.dom.queryAll('ul[data-role="listview"]')
    for listview in listviews
      $listview = $(listview)
      $listview.addClass('ui-listview')
      $listview.addClass('ui-listview-inset') if $listview.data('inset')
      lis = dom.queryAll('li',listview)
      for li in lis
        $li = $(li)
        $li.addClass('ui-li ui-btn')
        $a = $li.find('a')
        $inner = $('<div/>').addClass('ui-btn-inner').append($a)
        $li.empty().append($inner)
        # $li.wrapInner('<div class="ui-btn-inner"></div>')
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
