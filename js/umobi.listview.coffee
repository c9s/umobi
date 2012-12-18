###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!u','cs!umobi.core'], () ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  u.ready ->
    listviews = u.dom.queryAll('ul[data-role="listview"]')
    for listview in listviews
      ulistview = u(listview)
      listview.classList.add('ui-listview')
      listview.classList.add('ui-listview-inset') if ulistview.attr('data-inset')

      lis = dom.queryAll('li',listview)
      for li in lis
        li.classList.add('ui-li')
        li.classList.add('ui-btn')

        $li = $(li)
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
