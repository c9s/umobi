fs            = require "fs"
path          = require "path"
child_process = require "child_process"

module.exports = (grunt) ->
  grunt.registerTask "config:async", "git hashes for output headers", ->
    done = @async()
    global = grunt.config.get("global")
    
    # Get the long form sha output for inclusion in the non minified js and css
    child_process.exec global.ver.gitLongSha, (err, stdout, stderr) ->

      grunt.log.ok(stdout)

      global.shas.build_sha = stdout
      global.ver.min = grunt.template.process(global.ver.min, global.shas)

      # Get the short form sha output for inclusion in the minified js and css
      child_process.exec global.ver.gitShortSha, (err, stdout, stderr) ->
        global.shas.head_sha = stdout
        
        # NOTE not using a template here because the Makefile depends on the v@VERSION
        global.ver.header = grunt.file.read(global.files.license).replace(/v@VERSION/, global.shas.build_sha)
        grunt.config.set "global", global
        done()
