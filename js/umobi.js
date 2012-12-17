//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
require({
  // baseUrl: '/js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  paths: {
    "cs": "cs",
    "coffee-script": "coffee-script",
    "jquery":"jquery"
   }
});
//>>excludeEnd("umobiBuildExclude")

// load cs plugin and coffee-script
define([
"require",
"jquery",
"cs",
"coffee-script",
"cs!umobi.main"
], function(r,jQuery) { 
    r(["cs!umobi.main"]);
});
