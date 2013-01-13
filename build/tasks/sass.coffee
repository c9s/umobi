execSync = require "exec-sync"

module.exports = (grunt) ->
  grunt.registerTask "sass:compile", "compile sass files into css file", ->
    grunt.log.ok "Compiling SASS files."
    execSync "sass --compass --update css"
