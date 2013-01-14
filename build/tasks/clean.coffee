fs   = require "fs"
rmrf = require "rimraf"

module.exports = (grunt) ->
  config = grunt.config.get("global")
  grunt.registerTask "clean", "ensure the output directory is present", ->
    rmrf.sync config.dirs.output
    rmrf.sync config.dirs.temp
    rmrf.sync ".sass-cache"
