{
  baseUrl: "js"
  name: "umobi"
  exclude: [
    "jquery"
    "cs"
    "coffee-script"
    "depend"
    "text"
    "text!../version.txt"
  ]
  paths:
    "cs": "cs"
    "coffee-script": "coffee-script"
    "jquery":"jquery"
  # use bare option for coffee-script compiler,
  # this remove the function wrapper from coffee-script.
  CoffeeScript: { bare: true }
  out: rootFile + ".compiled.js"
  pragmas: { umobiBuildExclude: true }
  wrap:
    startFile: 'build/wrap.start'
    endFile: 'build/wrap.end'
  findNestedDependencies: true
  skipModuleInsertion: true
  optimize: "none"
}
