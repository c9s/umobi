// requirejs config
require({
  // baseUrl: '/js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  paths: {
    "cs": 'cs',
    "coffee-script": "coffee-script",
    "jquery":"jquery"
   }
});

// load cs plugin and coffee-script
document.getElementsByTagName('html')[0].className += 'ui-mobile ui-mobile-rendering';
define(["jquery"], function() { 
    require(["cs","coffee-script","cs!umobi.main"])
});

