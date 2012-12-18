//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
require({
  // baseUrl: '/js',
    urlArgs: 'bust=' + (new Date()).getTime()
    /*
    , paths: {
        "cs": "cs",
        "coffee-script": "coffee-script",
        "jquery":"jquery"
    }
    */
});
//>>excludeEnd("umobiBuildExclude")

// load cs plugin and coffee-script
define([
    "require",
    // "depend!zepto[]",
    // "z",
    "depend!define[]",
    "depend!jquery[]",
    "depend!classList[]",
    "cs",
    "coffee-script",
    "cs!umobi.core",
    "cs!u.dom",
    "cs!u",
    "cs!umobi.button",
    "cs!umobi.widget",
    "cs!umobi.zoom",
    "cs!umobi.listview",
    "cs!umobi.navigation",
    "cs!umobi.scroller",
    "cs!umobi.support",
    "cs!umobi.offlinecache",
    "cs!umobi.page",
    "cs!umobi.init"
], function(r,jQuery,cs,cs2,umobi) { 
    // r(["cs!umobi.init"]);
});
