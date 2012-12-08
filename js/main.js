// require(["cs","coffee-script","jquery"],['cs!csmain']);
require({
  // baseUrl: '/js',
  urlArgs: 'bust=' + (new Date()).getTime(),
  paths: {
    cs: 'cs',
    'coffee-script': 'coffee-script',
    "jquery":"jquery",
    // "jquery.alpha":"jquery.alpha",
    // "jquery.beta":"jquery.beta"
  }
}, ['cs!csmain']);
