###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ["cs!u.dom","cs!umobi.core"], (dom,umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    u = (a) -> new uSet(a)

    u.dom = window.dom
    u.ready = (cb) ->
      # if the document has already finished before we hook.
      if document.readyState is "complete"
        setTimeout(cb)
      else
        # The DOMContentLoaded event is fired when the document has finished
        # loading and being parsed, without waiting for stylesheets, images,
        # and subframes to be done loading (the load event can be used to
        # detect a fully-loaded page).
        document.addEventListener( "DOMContentLoaded", cb, false )

    # the load event can be used to detect a fully-loaded page.
    u.load = (cb) ->
      if document.readyState is "complete"
        setTimeout(cb)
      else
        window.addEventListener( "load", cb, false )

    class uSet
      constructor: (a) ->
        if a instanceof NodeList
          @els = a
          @length = a.length
        else if a instanceof Node
          @el = a
        else if typeof a is "object" and a instanceof Array
          @els = a
          @length = a.length
        else if typeof a is "string"
          @els = u.dom.queryAll(a)
        else
          throw new Error("u: unsupported argument")

      size: ->
        return @els.length  if @els
        return 1  if @el
        0

      get: (i) ->
        return @els[i] if @els
        if @el i is 0
          return @el

      all: ->
        return @els if @els
        return [ @el ] if @el
        return []

      children: (i) ->
        return new uSet(@get(i)) if i
        return new uSet(@els) if @els

      first: -> @children(0)

      last: -> @children( if @els.length > 0 then @els.length - 1 else 0 ) if @els

      addClass: (cls) -> @each (i, el) -> u.dom.addClass el, cls

      toggleClass: (cls) -> @each (i, el) -> u.dom.toggleClass el, cls

      removeClass: (cls) -> @each (i, el) -> u.dom.removeClass el, cls

      css: (n,v) ->
        # setter
        if( n and v )
          return @each (i,el) -> el.style[n] = v
        else if typeof n is "object" and @el
          return @each (i,el) ->
            for k,val in n
              el.style[k] = val
        # getter
        if typeof n is "string" and @el
          return @el.style[n]

      attr: (n,v) ->
        # setter
        if( n and v )
          return @each (i,el) -> el.setAttribute(n,v)
        else if typeof n is "object" and @el
          return @each (i,el) ->
            for k,val in n
              el.setAttribute(k,val)
        # getter
        if typeof n is "string" and @el
          return @el.getAttribute(n)

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


      click: (cb) -> @bind "click", cb

      on: (n,cb) -> @bind(n,cb)

      bind: (n, cb) -> @each (i, el, capture) -> el.addEventListener n, cb, capture

      parent: ->
        e = @get(0)
        return new uSet(e.parentNode) if e

      find: (sel) ->
        els = []
        for el in @all()
          nodes = u.dom.queryAll(sel,el)
          els = els.concat(nodes)
        return new uSet(els)

      siblings: (sel) ->
        return @parent().find(sel) if sel
        return @parent().children()

      filter: (cb) ->
        newlist = []
        els = @all()
        for e in els
          newlist.push(e) if cb.call(e,e)
        return new uSet(newlist)

      next: ->
        e = @get(0)
        return new uSet(e.nextSibling) if e

      prev: ->
        e = @get(0)
        return new uSet(e.prevSibling) if e

      ###
      # Returns style or computed style
      ###
      style: (computed) ->
        return unless @el
        return window.getComputedStyle(@el) if computed
        @el.style

      height: (a) ->
        if a
          return @each (i,e) -> e.style.height = parseInt(a) + 'px'
        else
          return unless @el
          return parseInt(@el.style.height) if @el.style.height
          parseInt(@style(1).height)

      width: (a) ->
        if a
          @each (i,e) -> e.style.width = parseInt(a) + 'px'
        else
          return unless @el
          return parseInt(@el.style.width) if @el.style.width
          parseInt(@style(1).width)

      # convert element or element collection to jQuery object.
      jQuery: () -> $( @els or @el )

    window.u = u
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return window.u
###
//>>excludeEnd("umobiBuildExclude")
###
