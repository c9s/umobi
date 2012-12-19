define [],() ->
  module 'Extended String Test'
  test 'toCamelCase', () ->
    equal('data-user-name'.toCamelCase(),'DataUserName')

  test 'toLowerCamelCase', () ->
    equal('data-user-name'.toLowerCamelCase(),'dataUserName')

  test 'toDashCase', () ->
    equal('dataUserName'.toDashCase(),'data-user-name')
