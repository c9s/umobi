
define [] , () ->
  module "u.js unit test"

  test "Core", () ->
    ok u, "Got global u helper"

  test "Test query selector", () ->
    elements = u("#test1 .foo")
    ok elements, "Got elements"
    equal 6, elements.size()

    elements = u("#test1")
    ok elements, "Got elements"
    equal 1, elements.size()

  test "Test all()", () ->
    elements = u("#test1 .foo")
    for el in elements.all()
      ok el, "Get element"

  test "Test get(i)", () ->
    elements = u("#test1 .foo")
    el = elements.get(0)
    ok el

  test "Test children(i)", () ->
    elements = u("#test1 .foo")
    el = elements.children(0)
    ok el

  test "Test first()", () ->
    ok u("#test1 .foo").first()
    ok u("#test1").first()

  test "Test last()", () ->
    ok u("#test1 .foo").last()
    ok u("#test1").last()

