requirejs = require "requirejs"
path      = require "path"
fs        = require "fs"

module.exports = (grunt) ->
  config = grunt.config.get("global")
  helpers = config.helpers
  grunt.registerTask "js:compile", ->
    require = grunt.config.get("js").require
    global_config = grunt.config.get("global")
    
    # pull the includes together using require js
    grunt.log.writeln "requriejs optimizing..."
    requirejs.optimize require
    
    # replace the version with the value in version.text
    grunt.file.copy require.out, require.out,
      process: (fileContents) ->
        fileContents.replace /__version__/, "\"" + global_config.ver.official + "\""


  grunt.registerTask "js:cleanup", "compile and minify the js", ->
    require = grunt.config.get("js").require
    
    # remove the requirejs compile output
    fs.unlink require.out
  
  # NOTE custom dasks don't accept dependencies so we alias
  grunt.registerTask "js", "config:async js:compile concat:js uglify js:cleanup".split(" ")
