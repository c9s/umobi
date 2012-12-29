# u.js library

## Widget class

## Widget API

Define your widget:

    # calendar
    u.widget 'calendar', (options) ->

      # define your calendar widget here, 
      # which is based on u.Widget
      class CalendarWidget extends u.Widget
        constructor: () ->
        create: () ->
        update: () ->
      return new Widget

To use your widget:

    var widget = u('#container').calendar({ url: ... });
    widget.create()
    widget.update()

