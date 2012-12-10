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
define(["jquery"], function() { 
    var $html = $('html')
    $html.addClass('ui-mobile ui-mobile-rendering')
    require(["cs","coffee-script","cs!umobi.main"])
});

