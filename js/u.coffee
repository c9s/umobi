
define ["jquery", "umobi.dom"], ($, dom) ->
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

    addClass: (cls) ->
      @each (i, el) -> dom.addClass el, cls
      this

    removeClass: (cls) ->
      @each (i, el) -> dom.removeClass el, cls
      this

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

    toggleClass: (cls) ->
      @each (i, el) -> dom.toggleClass el, cls
      this

    click: (cb) -> @bind "click", cb

    on: (n,cb) ->
      m = n.charAt(0).toUpperCase() + n.substr(1)
      @bind(m,cb)

    bind: (n, cb) ->
      @each (i, el) -> el.addEventListener n, cb

    style: (computed) ->
      return unless @element
      return window.getComputedStyle(@element) if computed
      @element.style

    height: (a) ->
      if a
        @each (i,e) -> e.style.height = parseInt(a) + 'px'
      else
        return unless @element
        return parseInt(@element.style.height) if @element.style.height
        parseInt(@style(1).height)

  
  # export to global
  window.u = u

