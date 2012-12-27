
define ["cs!u.dom","cs!u"], () ->
  u._widgets = { }
  u.widget = (name,factory) ->
    @_widgets[ name ] = factory
