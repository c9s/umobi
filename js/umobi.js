// requirejs config
require({
  // baseUrl: '/js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  CoffeeScript: { bare: true },
  paths: {
    "cs": "cs",
    "coffee-script": "coffee-script",
    "jquery":"jquery"
   }
});

// Add rendering class to hide content when rendering UI components.
document.documentElement.className += 'ui-mobile ui-mobile-rendering';
// document.getElementsByTagName('html')[0].className += 'ui-mobile ui-mobile-rendering';

// load cs plugin and coffee-script
define([
"require",
"jquery",
"cs",
"coffee-script"
], function(require,jQuery) { 
    require(["cs!umobi.main"])
});
