(->
  umobi.button = { }

  # get buttons
  umobi.button.all = () -> u.dom.queryAll('[data-role="button"]')

  umobi.button.markup = (el) ->
    $el = $(el)
    $el.wrapInner("""
      <span class="ui-btn ui-btn-corner-all">
        <span class="ui-btn-text">
        </span>
      </span>
    """)

  umobi.button.bindClassEvents = (el) ->
    $el = $(el)
    # class name map hash
    theme = umobi.config.theme
    cmap =
      up:    "ui-btn-up-#{theme}"
      down:  "ui-btn-down-#{theme}"
      hover: "ui-btn-hover-#{theme}"
    $el.addClass cmap.up
    $el.hover (->
      u(@).removeClass([cmap.up,cmap.down]).addClass(cmap.hover)
    ), (->
      u(@).removeClass([cmap.down,cmap.hover]).addClass(cmap.up)
    )

    $el.on "tap", (e) ->
      u(@).removeClass(cmap.hover).removeClass(cmap.up).addClass(cmap.down)

    $el.on "mousedown", (e) ->
      u(@).removeClass(cmap.hover).removeClass(cmap.up).addClass(cmap.down)

    $el.on 'mouseup', (e) ->
      u(@).removeClass(cmap.down).addClass(cmap.hover)

  u.ready ->
    linkbuttons = u('a[data-role="button"]')
    for el in linkbuttons.all()
      link = u(el)
      link.data("corners",true)
        .data("shadow",true)
        .data("theme",umobi.config.theme)
      link.addClass(["ui-btn","ui-shadow","ui-btn-corner-all"])
      link.addClass("ui-mini") if link.data("mini")
      link.addClass("ui-inline") if link.data("inline")

      # initialize <a> as a button
      $link = $(el)
      $link.wrapInner("""
          <span class="ui-btn-text">
          </span>
      """)
      $link.wrapInner("""
        <span class="ui-btn-inner">
        </span>
      """)

#        if icontype = link.data("icon")
#          $link.find(".ui-btn-text").before("<span class=\"ui-icon icon-#{ icon }\"></span>")

      if icontype = $link.data("icon")
        iconpos = $link.data("iconpos")
        iconpos ?= "left"
        $icon = $('<span/>')
        $icon.addClass("ui-icon icon-#{ icontype }")
        $icon.addClass("ui-icon-#{ iconpos }")
        $link.addClass("ui-btn-icon-#{ iconpos }")
        $link.children(0).prepend($icon)

      umobi.button.bindClassEvents($link)

    buttons = u('button, input[type="button"]')
    for btn in buttons.all()
      b = u(btn)
      b.addClass(["ui-btn","ui-btn-corner-all","ui-shadow"])
      b.addClass("ui-mini") if b.data("mini")
      b.addClass("ui-inline") if b.data("inline")

      $(btn).wrapInner("""
        <span class="ui-btn-text">
        </span>
      """)
      $(btn).wrapInner("""
        <span class="ui-btn-inner">
        </span>
      """)

      if icontype = b.data("icon")
        iconpos = b.data("iconpos")
        iconpos ?= "left"

        $icon = $('<span/>')
        $icon.addClass("ui-icon icon-#{ icontype }")
        $icon.addClass("ui-icon-#{ iconpos }")
        b.addClass("ui-btn-icon-#{ iconpos }")
        $(btn).children(0).prepend($icon)

      umobi.button.bindClassEvents($(btn))
    # for button in buttons
)()
