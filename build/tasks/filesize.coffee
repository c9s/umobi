path      = require "path"
filesize  = require "filesize"
du        = require "du-sync"

module.exports = (grunt) ->
  grunt.registerTask "filesize", ->
    ###
      config = {
        "Section":
          "Title": [ files... ]
          "Title2": [ files... ]
      }
    ###
    filesizeSections = grunt.config.get("filesize")
    for sectionTitle, section of filesizeSections
      grunt.log.header sectionTitle
      total = 0
      for title,files of section
        sum = 0
        sum += du(file) for file in files
        total += sum
        grunt.log.writeln( "#{ title }: " + filesize(sum) )
      grunt.log.writeln("Total size: #{ filesize(total) }")
