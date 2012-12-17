###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ["jquery","cs!umobi.core"], ($, umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
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
      
      # http://jsperf.com/jquery-addclass-vs-dom-classlist/2
      dom.addClass = (e, cls) ->
        if @supportClassList
          e.classList.add cls
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
      dom.bind = (el, n, cb) -> el.addEventListener n, cb

    u = (a) ->
      @dom = dom
      if a instanceof NodeList
        @els = a
        @length = a.length
      else if a instanceof Node
        @el = a
      else if typeof a is "string"
        @els = @dom.queryAll(a)
      else
        throw "u: unsupported argument"
    u:: =
      size: ->
        return @els.length  if @els
        return 1  if @el
        0

      get: (i) ->
        if @els
          return @els[i]
        else @el  if i is 0

      addClass: (cls) -> @each (i, el) -> dom.addClass el, cls

      removeClass: (cls) -> @each (i, el) -> dom.removeClass el, cls

      css: (n,v) ->
        # setter
        if( n and v )
          return @each (i,el) -> el.style[n] = v
        else if typeof n is "object" and @element
          return @each (i,el) ->
            for k,val in n
              el.style[k] = val
        # getter
        if typeof n is "string" and @element
          return @element.style[n]

      attr: (n,v) ->
        # setter
        if( n and v )
          return @each (i,el) -> el.setAttribute(n,v)
        else if typeof n is "object" and @element
          return @each (i,el) ->
            for k,val in n
              el.setAttribute(k,val)
        # getter
        if typeof n is "string" and @element
          return @element.getAttribute(n)

      each: (cb) ->
        if @els
          i = 0
          len = @els.length
          while i < len
            cb i, @els[i]
            i++
        else
          cb 0, @el
        this

      toggleClass: (cls) -> @each (i, el) -> dom.toggleClass el, cls

      click: (cb) -> @bind "click", cb

      on: (n,cb) -> @bind(n,cb)

      bind: (n, cb) -> @each (i, el) -> el.addEventListener n, cb

      ###
      # Returns style or computed style 
      ###
      style: (computed) ->
        return unless @element
        return window.getComputedStyle(@element) if computed
        @element.style

      height: (a) ->
        if a
          return @each (i,e) -> e.style.height = parseInt(a) + 'px'
        else
          return unless @element
          return parseInt(@element.style.height) if @element.style.height
          parseInt(@style(1).height)

      width: (a) ->
        if a
          @each (i,e) -> e.style.width = parseInt(a) + 'px'
        else
          return unless @element
          return parseInt(@element.style.width) if @element.style.width
          parseInt(@style(1).width)

    window.u = u
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return window.u
###
//>>excludeEnd("umobiBuildExclude")
###
