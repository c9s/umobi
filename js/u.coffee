###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ["jquery","cs!u.dom","cs!umobi.core"], ($,dom,umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    u = (a) ->
      if a instanceof NodeList
        @els = a
        @length = a.length
      else if a instanceof Node
        @el = a
      else if typeof a is "string"
        @els = @dom.queryAll(a)
      else
        throw new Error "u: unsupported argument"
    u.dom = window.dom

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
        return this

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
