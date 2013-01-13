path = require "path"
fs = require "fs"
coffee = require "coffee-script"

module.exports = (grunt) ->

  dirs =
    output: "compiled"
    temp: "tmp"

  # this will change for the deploy target to include version information
  outputPath = (name) -> path.join(dirs.output, name)

  verOfficial = grunt.file.read("version.txt").replace(/\n/, "")

  # as we need the result, we can't use coffee.eval, we use eval in current
  # context instead of it
  readCoffee = (file) -> eval coffee.compile(grunt.file.read(file),{bare:1})

  # TODO again, I'd like to use grunt params but I'm not sure
  #      how to get that working with a custom task with deps
  theme = process.env.THEME or "default"

  # version suffix
  suffix = (if process.env.IS_DEPLOY_TARGET is "true" then "-" + verOfficial else "")
  names =
    base: "umobi" + suffix
    root: "umobi" + suffix
    structure: "umobi.structure" + suffix
    theme: "umobi.theme" + suffix

  rootFile = outputPath(names.root)
  structureFile = outputPath(names.structure)
  themeFile = outputPath(names.theme)

  # CSSMIN configuration
  cssmin = { all: { } }
  cssmin.all[ "#{rootFile}.min.css" ]      = ["<%= global.ver.min %>", rootFile + ".css"]
  cssmin.all[ "#{structureFile}.min.css" ] = ["<%= global.ver.min %>", structureFile + ".css"]
  cssmin.all[ "#{themeFile}.min.css" ]     = ["<%= global.ver.min %>", themeFile + ".css"]

  # Project configuration.
  grunt.config.init
    sizereport:
      "Core":
        "Compressed stylesheet": [ rootFile + ".min.css" ]
        "Compressed javascript": [ rootFile + ".min.js" ]
      "Custom font-awesome":
        "Stylesheet": [ "compiled/customfont/fontawesome.css" ]
        "TTF fonts": [ "compiled/customfont/fontawesome-webfont.ttf" ]
        "EOT fonts": [ "compiled/customfont/fontawesome-webfont.eot" ]
        "WOFF fonts": [ "compiled/customfont/fontawesome-webfont.woff" ]
      "Images":
        "Image files": [ "compiled/images" ]

    jshint: readCoffee "build/jshint.coffee"
    
    # TODO add test files here once we can specify different configs for
    #      different globs
    # lint:
    #  files: ["js/**/*.mobile.*.js", "js/*/*.js"]

    coffeelint:
      app: ['js/*.coffee']
    coffeelintOptions:
      no_backticks:
        level: "ignore"
      max_line_length:
        value: 100
        level: "ignore"
    
    # NOTE these configuration settings are used _after_ compilation has taken place
    #      using requirejs. Thus the .compiled extensions. The exception being the theme concat
    concat:
      options:
        banner: "<%= global.ver.header %>"
      js:
        src: [ rootFile + ".compiled.js"]
        dest: rootFile + ".js"

      structure:
        src: [ structureFile + ".compiled.css"]
        dest: structureFile + ".css"

      regular:
        src: [ rootFile + ".compiled.css"]
        dest: rootFile + ".css"

      theme:
        src: [ "css/themes/" + theme + "/umobi.css"]
        dest: themeFile + ".css"

    qunit:
      all: ["tests/**/*.html","tests/*.html"]
    
    # NOTE the keys are filenames which, being stored as variables requires that we use
    #      key based assignment. See below.
    uglify: `undefined`
    cssmin: cssmin
    compress: readCoffee "build/compress.coffee"
    
    # JS config, mostly the requirejs configuration
    # full example: https://github.com/jrburke/r.js/blob/master/build/example.build.js
    js: { require: readCoffee "build/require-js.coffee" }
    
    # CSS config, mostly the requirejs configuration
    css:
      theme: process.env.THEME or "default"
      themeFile: themeFile
      require:
        all:
          cssIn: "css/themes/" + theme + "/umobi.css"
          optimizeCss: "standard.keepComments.keepLines"
          baseUrl: "."
          out: rootFile + ".compiled.css"
        structure:
          cssIn: "css/structure/umobi.css"
          out: structureFile + ".compiled.css"

    global:
      dirs: dirs
      names: names
      files:
        license: "LICENSE.txt"

      
      # other version information is added via the asyncConfig helper that
      # depends on git commands (eg ver.min, ver.header)
      ver:
        official: verOfficial
        min: "/*! umobi v<%= build_sha %> umobi.com !*/"
        gitLongSha: "git log -1 --format=format:\"Git Build: SHA1: %H <> Date: %cd\""
        gitShortSha: "git log -1 --format=format:\"%H\""

      shas: {}

  
  # MIN configuration
  uglify = { js: { files: {} } }
  uglify.options = { banner: "<%= global.ver.min %>" }
  uglify.js.files[ rootFile + ".min.js" ] = [rootFile + ".js"]
  grunt.config.set "uglify",uglify
  
  
  
  # authors task
  grunt.loadNpmTasks "grunt-git-authors"
  grunt.loadNpmTasks "grunt-junit"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-qunit"
  grunt.loadNpmTasks "grunt-contrib-compress"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-sizereport"

  # csslint and cssmin tasks
  grunt.loadNpmTasks "grunt-css"
  
  grunt.registerTask "zip", "js css compress:zip".split(' ')


  grunt.event.on 'qunit.spawn', (url) ->
    grunt.log.ok("Running test: " + url)
  
  # load the project's default tasks
  grunt.loadTasks "build/tasks"

  # set the default task.
  grunt.registerTask "default", ["coffeelint","js","css","qunit","sizereport"]
