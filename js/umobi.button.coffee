###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!u.dom','cs!u','cs!umobi.core'], ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
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
    $el.on 'mousedown',->
      u(@).removeClass(cmap.hover).removeClass(cmap.up).addClass(cmap.down)
    $el.on 'mouseup',->
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

      # initialize <a> as a button
      $link = $(el)
      $link.wrapInner("""
        <span class="ui-btn ui-btn-corner-all">
          <span class="ui-btn-text">
          </span>
        </span>
      """)
      if icon = link.data("icon")
        $link.find(".ui-btn-text").before("<span class=\"ui-icon icon-#{ icon }\"></span>")
      umobi.button.bindClassEvents($link)

    buttons = u('button, input[type="button"]')
    for button in buttons.all()
      u(button).addClass(["ui-btn","ui-btn-corner-all","ui-shadow"])
      u(button).addClass("ui-mini") if u(button).data("mini")
      umobi.button.bindClassEvents($(button))

    # for button in buttons
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
