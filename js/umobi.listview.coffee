
# listview widgets
define ['jquery','umobi.dom'], ($,dom) ->
  $ ->
    listviews = dom.queryAll('ul[data-role="listview"]')
    for listview in listviews
      $listview = $(listview)
      $listview.addClass('ui-listview')
      lis = dom.queryAll('li',listview)
      for li in lis
        console.log li
