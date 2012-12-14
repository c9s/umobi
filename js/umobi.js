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

// load cs plugin and coffee-script
document.getElementsByTagName('html')[0].className += 'ui-mobile ui-mobile-rendering';
define(["jquery","cs","coffee-script"], function(jQuery) { 
    require(["cs!umobi.main"])
});
