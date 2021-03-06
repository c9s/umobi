(->
  # DOM Helpers
  dom = {}

  ###
  # See if current DOM support classList (HTML5)
  ###
  dom.supportClassList = (typeof document.documentElement.classList isnt "undefined")

  dom.query = (q, c) ->
    c = c or document
    # querySelector is only available in IE.
    c.querySelector q

  dom.queryAll = (q, c) ->
    c = c or document
    throw new Error("Object " + typeof(c) + " does not contains querySelectorAll method") unless c.querySelectorAll
    # return document.querySelectorAll(q) unless c.querySelectorAll
    
    # querySelectorAll is available in IE8, Chrome, Firefox and Safari
    # in this library we don t consider IE7
    c.querySelectorAll q

# get element by id, which is faster than querySelectorAll
  dom.get = (dom, c) ->
    c = c or document
    c.getElementById dom


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


  dom.bind = (el, n, cb) -> el.addEventListener n, cb
  window.dom = dom
)()
