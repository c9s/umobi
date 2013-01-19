#  define [
#    "cs!u"
#    "cs!umobi.core"
#    "cs!umobi.page"
#  ], ->

# support HTML5 tags, and custom "page" tag.
tags = ["article","section","header","footer","aside","details","summary","page"]
f = document.createDocumentFragment()
for tag in tags
  f.appendChild( d.createElement(tag) )
