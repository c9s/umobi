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
  umobi.dom = (->
    d = {}
    d.supportClassList = (typeof document.documentElement.classList isnt "undefined")
    d.query = (q, c) ->
      c = c or document
      c.querySelector q

    d.queryAll = (q, c) ->
      c = c or document
      
      # querySelectorAll is available in IE8, Chrome, Firefox and Safari
      # in this library we don t consider IE7
      c.querySelectorAll q
    
    # get element by id, which is faster than querySelectorAll
    d.get = (d, c) ->
      c = c or document
      c.getElementById d

    
    # convert element collection to array
    # which is needed when iterating huge collection.
    d.collectionToArray = (c) ->
      i = 0
      len = c.length
      list = []
      while i < len
        list.push c[i]
        i++
      list

    
    # get by tagname
    d.byTagName = (n, c) ->
      c = c or document
      c.getElementsByTagName n

    d.byClassName = (n, c) ->
      c = c or document
      c.getElementsByClassName n

    
    # http://jsperf.com/jquery-addclass-vs-dom-classlist/2
    d.addClass = (e, cls) ->
      if typeof e.classList isnt "undefined"
        e.classList.add cls
      
      # jquery fallback
      else
        $(e).addClass cls

    d.removeClass = (e, cls) ->
      if @supportClassList
        e.classList.remove cls
      else
        $(e).removeClass cls

    d.toggleClass = (e, cls) ->
      if @supportClassList
        e.classList.toggle cls
      else
        $(e).toggleClass cls

    d.bind = (el, n, cb) -> el.addEventListener n, cb
    return d
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return umobi.dom
###
//>>excludeEnd("umobiBuildExclude")
###
