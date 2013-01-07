requirejs = require "requirejs"
path      = require "path"
fs        = require "fs"
filesize = require "filesize"
async = require "async"

readSizeRecursive = (item) ->
  stats = fs.lstatSync item
  total = stats.size
  if stats.isDirectory()
    list = fs.readdirSync item
    for diritem in list
      size = readSizeRecursive path.join(item, diritem)
      total += size
    return total
  else
    return total

module.exports = (grunt) ->
  grunt.registerTask "stat", ->
    rootFile = "compiled/umobi"
    statCss = fs.statSync( rootFile + ".min.css" )
    statJs  = fs.statSync( rootFile + ".min.js" )
    sizeImage = readSizeRecursive( "compiled/images" )
    sizeCss = statCss.size
    sizeJs = statJs.size
    grunt.log.ok( "Compressed JavaScript: #{ rootFile }.min.js size: " + filesize(sizeJs) )
    grunt.log.ok( "Compressed StyleSheet: #{ rootFile }.min.css size: " + filesize(sizeCss) )
    grunt.log.ok( "Image size: " + filesize(sizeImage) )
    grunt.log.ok( "Total: " + filesize(sizeJs + sizeCss + sizeImage) )

