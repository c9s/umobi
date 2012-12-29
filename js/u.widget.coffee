
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
    @_widgets[ name ] = factory

