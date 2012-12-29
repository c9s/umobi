
define [] , () ->
  module "u.js DOM manipulation tests"

  test "Core", () ->
    ok u, "Got global u helper"

  test "QuerySelector Test", () ->

    elements = u("#test1 .foo")
    ok elements, "Got elements"
    equal 6, elements.size()

    elements = u("#test1")
    ok elements, "Got elements"
    equal 1, elements.size()


