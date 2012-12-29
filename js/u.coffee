###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ["cs!str","cs!u.dom","cs!umobi.core"], (dom,umobi) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    u = (a) ->
      return a if typeof a is "object" and a instanceof USet
      return new USet(a)

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

    ensureClassArray = (c) ->
      return c.split(" ") if typeof c is "string"
      return c() if typeof c is "function"
      return c
      # NOTE: `instanceof` is slower than `typeof`
      # return c if c instanceof Array

    class USet
      constructor: (a) ->
        if typeof a is "string"
          @els = u.dom.queryAll(a)
        else if typeof a is "object" and a instanceof Array
          @els = a
          @length = a.length
        else if a instanceof NodeList
          @els = a
          @length = a.length
        else if typeof a is "object" or a instanceof Node
          @el = a
        else
          console.error(a) if window.console
          throw new Error("u: unsupported argument")

      size: ->
        return @els.length  if @els
        return 1  if @el
        0

      get: (i) ->
        return @els[i] if @els
        return @el if i is 0

      all: ->
        return @els if @els
        return [ @el ] if @el
        return []

      children: (i) ->
        return u(@get(i)) if i
        return u(@els) if @els

      first: -> @children(0)

      last: -> @children( if @els.length > 0 then @els.length - 1 else 0 ) if @els

      ###
      addClass, toggleClass, removeClass is little different from jQuery
      which takes a string for single class or an array for multiple
      class names.
      
      As you are already using u(), you should use
      
         u('element').addClass('class1 class2'.split(' '))
      
      Or
      
         u('element').addClass('class1')
      
      Instead of
      
         u('element').addClass('class1 class2')
      
      Because the classList is faster 8 times than jQuery.addClass
      
      Performance:
      http://jsperf.com/jquery-addclass-vs-dom-classlist/4
      
      Support:
      https://developer.mozilla.org/en-US/docs/DOM/element.classList
      ###
      addClass: (cls) ->
        if typeof cls is "object"
          return @each (i, el) ->
            for c in cls
              el.classList.add(c)
        else
          return @each (i, el) -> el.classList.add(cls)

      toggleClass: (cls) ->
        if typeof cls is "object"
          return @each (i, el) -> el.classList.toggle(c) for c in cls
        else
          return @each (i, el) -> el.classList.toggle(cls)

      removeClass: (cls) ->
        if typeof cls is "object"
          return @each (i, el) -> el.classList.remove(c) for c in cls
        else
          return @each (i,el) -> el.classList.remove(cls)

      hasClass: (cls) ->
        all = @all()
        for el in all
          if not el.classList.contains(cls)
            return false
        return true

      css: (n,v) ->
        # setter
        if( n and v )
          return @each (i,el) -> el.style[n] = v
        else if typeof n is "object"
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
        else if typeof n is "object"
          return @each (i,el) ->
            for k,val in n
              el.setAttribute(k,val)
        # getter
        if typeof n is "string"
          return @get(0)?.getAttribute(n)

      empty: () -> @each (i,el) -> el.innerHTML = ''

      each: (cb) ->
        if @els
          i = 0
          len = @els.length
          while i < len
            b = cb i, @els[i]
            break if b is false
            i++
        else
          el = @get(0)
          cb 0, el if el
        return this

      ###
      Trigger a native element
      
      @param string n event name
      ###
      trigger: (n) ->
        # createEvent: https://developer.mozilla.org/en-US/docs/DOM/document.createEvent
        evt = document.createEvent("HTMLEvents")

        # https://developer.mozilla.org/en-US/docs/DOM/event.initEvent
        evt.initEvent(n, true, true) # event type,bubbling,cancelable
        return @each (i,el) -> el.dispatchEvent(evt)

      click: (cb) -> @bind "click", cb

      on: (n,cb) -> @bind(n,cb)

      bind: (n, cb) -> @each (i, el, capture) -> el.addEventListener n, cb, capture

      parent: ->
        e = @get(0)
        return u(e.parentNode) if e

      find: (sel) ->
        els = []
        for el in @all()
          nodes = u.dom.queryAll(sel,el)
          els.push(n) for n in nodes
        return u(els)

      siblings: (sel) ->
        return @parent().find(sel) if sel
        return @parent().children()

      filter: (cb) ->
        newlist = []
        els = @all()
        for e in els
          newlist.push(e) if cb.call(e,e)
        return u(newlist)

      next: ->
        e = @get(0)
        return u(e.nextSibling) if e

      prev: ->
        e = @get(0)
        return u(e.prevSibling) if e

      ###
      Returns style or computed style
      ###
      style: (computed,update = false) ->
        el = @get(0)
        return unless el
        if computed
          return @cstyle if @cstyle and not update
          return @cstyle = window.getComputedStyle(el)
        return el.style

      data: (n,v) ->
        el = @get(0)
        if el
          # setter
          if n and v
            if typeof v is "string" or typeof v is "boolean"
              return @attr 'data-' + n, v
            else
              console.error('not implemented yet.')
          # getter
          else if n
            datakey = n.toLowerCamelCase()
            if typeof el.dataset isnt 'undefined'
              return el.dataset[datakey]
            else
              return @attr(n)
        return this

      height: (a) ->
        # setter
        if a
          return @each (i,e) -> e.style.height = parseInt(a) + 'px'
        else
          el = @get(0)
#            console.log el.style.height
#            console.log @style(1).height
          return parseInt(el.style.height) if el?.style.height
          parseInt(@style(1).height)

      width: (a) ->
        if a
          return @each (i,e) -> e.style.width = parseInt(a) + 'px'
        else
          el = @get(0)
          return parseInt(el.style.width) if el?.style.width
          parseInt(style(1).width)

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
