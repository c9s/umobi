// requirejs config
require({
  // baseUrl: '/js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  paths: {
    "cs": "lib/cs",
    "coffee-script": "lib/coffee-script",
    "jquery":"lib/jquery"
   }
});

// Add rendering class to hide content when rendering UI components.
document.documentElement.className += 'ui-mobile ui-mobile-rendering';
// document.getElementsByTagName('html')[0].className += 'ui-mobile ui-mobile-rendering';

// load cs plugin and coffee-script
define(["jquery","cs","coffee-script"], function(jQuery) { 
    require(["cs!umobi.main"])
});
