path      = require "path"
filesize  = require "filesize"
du        = require "du-sync"

module.exports = (grunt) ->
  grunt.registerTask "stat", ->
    ###
      config = {
        "Title": [ files... ]
        "Title2": [ files... ]
      }
    ###
    statConfig = grunt.config.get("stat")
    total = 0
    for title,files of statConfig
      sum = 0
      sum += du(file) for file in files
      total += sum
      grunt.log.ok( "#{ title }: " + filesize(sum) )
    grunt.log.ok( "===============================" )
    grunt.log.ok( "Total size: #{ filesize(total) }" )
