define [],() ->
  test 'string test', () ->
    equal('data-user-name'.toCamelCase(),'DataUserName')
    equal('data-user-name'.toLowerCamelCase(),'dataUserName')
    equal('dataUserName'.toDashCase(),'data-user-name')

  test 'basic test', ->
    expect(1)
    ok(true, 'this had better work.')

  test 'can access the DOM', ->
    expect(1)
    fixture = document.getElementById('qunit-fixture')
    equal(fixture.innerText, 'this had better work.', 'should be able to access the DOM.')
