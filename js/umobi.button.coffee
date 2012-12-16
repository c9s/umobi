define ['jquery','cs!umobi.core'], ->
  $ ->
    buttons = umobi.dom.queryAll('[data-role="button"]')
    for button in buttons
      $(button)
