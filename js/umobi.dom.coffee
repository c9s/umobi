###
# query selector vs jquery
# http://jsperf.com/jquery-vs-queryselectorall-to-array
#
# get element by id vs query selector
# http://jsperf.com/getelementbyid-v-s-queryselector
###
###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ["jquery", "cs!umobi.core"], ($, umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  dom = {}
  dom.supportClassList = (typeof document.documentElement.classList isnt "undefined")
  dom.query = (q, c) ->
    c = c or document
    c.querySelector q

  dom.queryAll = (q, c) ->
    c = c or document
    
    # querySelectorAll is available in IE8, Chrome, Firefox and Safari
    # in this library we don t consider IE7
    c.querySelectorAll q
  
  # get element by id, which is faster than querySelectorAll
  dom.get = (d, c) ->
    c = c or document
    c.getElementById d

  
  # convert element collection to array
  # which is needed when iterating huge collection.
  dom.collectionToArray = (c) ->
    i = 0
    len = c.length
    list = []
    while i < len
      list.push c[i]
      i++
    list

  
  # get by tagname
  dom.byTagName = (n, c) ->
    c = c or document
    c.getElementsByTagName n

  dom.byClassName = (n, c) ->
    c = c or document
    c.getElementsByClassName n

  
  # http://jsperf.com/jquery-addclass-vs-dom-classlist/2
  dom.addClass = (e, cls) ->
    if typeof e.classList isnt "undefined"
      e.classList.add cls
    
    # jquery fallback
    else
      $(e).addClass cls

  dom.removeClass = (e, cls) ->
    if @supportClassList
      e.classList.remove cls
    else
      $(e).removeClass cls

  dom.toggleClass = (e, cls) ->
    if @supportClassList
      e.classList.toggle cls
    else
      $(e).toggleClass cls

  dom.bind = (el, n, cb) ->
    el.addEventListener n, cb

  umobi.dom = dom
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return dom
###
//>>excludeEnd("umobiBuildExclude")
###
