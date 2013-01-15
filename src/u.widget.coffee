
define ["cs!u.dom","cs!u"], () ->
  u._widgets = { }

  ###
  Widget base class
  ###
  class u.Widget
    constructor: () ->

  ###
  Widget factory method
  
     @param string name
     @param closure factory
  ###
  u.widget = (name,factory) ->
    # register factory method to u.js
    if factory
      u[ name ] = (options) ->
        return factory.apply(options)
