path      = require "path"
filesize  = require "filesize"
du        = require "du-sync"

module.exports = (grunt) ->
  grunt.registerTask "filesize", ->
    ###
      config = {
        "Title": [ files... ]
        "Title2": [ files... ]
      }
    ###
    filesizeConfig = grunt.config.get("filesize")
    total = 0
    for title,files of filesizeConfig
      sum = 0
      sum += du(file) for file in files
      total += sum
      grunt.log.ok( "#{ title }: " + filesize(sum) )
    grunt.log.ok( "===============================" )
    grunt.log.ok( "Total size: #{ filesize(total) }" )
