
define ["cs!u","cs!umobi.core"], ->
  slider =
    create: (el) ->
      $widget = $("<div/>").addClass("ui-slider ui-btn ui-btn-down-c ui-btn-corner-all")

      $a = $("<a/>").addClass("ui-slider-handle ui-btn ui-btn-up-c ui-shadow ui-btn-corner-all")
      $a.addClass("ui-btn-up-c")
      $btn = $("<span/>").addClass("ui-btn-inner ui-btn-corner-all")
      $a.append($btn).appendTo($widget)

      # force changing type
      el.type = "number"

      $(el).after($widget)
      # el.parentNode.removeChild(el)

  u.ready ->
    for el in u('input[type="range"]').all()
      slider.create(el)
