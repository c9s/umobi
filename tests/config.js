QUnit.config.autostart = false;
require.config({
  baseUrl: '../js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  CoffeeScript: { bare: true },
  paths: {
    "tests": "../tests/tests",
    "cs": "cs",
    "coffee-script": "coffee-script",
    "jquery":"jquery"
  }
});
