path = require "path"
fs = require "fs"
coffee = require "coffee-script"
child_process = require("child_process")

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


  # Project configuration.
  grunt.config.init
    global:
      dirs: dirs
      names: names
      files:
        license: "LICENSE.txt"
      
      # other version information is added via the asyncConfig helper that
      # depends on git commands (eg ver.min, ver.header)
      ver:
        official: verOfficial
        min: "/*! umobi v<%= global.shas.build_sha %> umobi.com !*/"
        gitLongSha: "git log -1 --format=format:\"Git Build: SHA1: %H <> Date: %cd\""
        gitShortSha: "git log -1 --format=format:\"%H\""
      shas: {}

    coffee:
      compile:
        files:
          "compiled/umobi.js": [ "src/*.coffee" ]
    coffeelint: { app: ['src/*.coffee'] }
    coffeelintOptions:
      no_backticks:
        level: "ignore"
      max_line_length:
        value: 100
        level: "ignore"

    jshint: readCoffee "build/jshint.coffee"

    
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
    
    # JS config, mostly the requirejs configuration
    # full example: https://github.com/jrburke/r.js/blob/master/build/example.build.js
    js: { require: readCoffee "build/require-js.coffee" }
    
    # CSS config, mostly the requirejs configuration
    css:
      theme: process.env.THEME or "default"
      themeFile: themeFile
      require:
        all:
          cssIn: ["css/umobi.all.css"]
          optimizeCss: "standard.keepComments.keepLines"
          baseUrl: "."
          out: rootFile + ".compiled.css"
        structure:
          cssIn: "css/structure/umobi.css"
          out: structureFile + ".compiled.css"

    # config for grunt-css
    cssmin:
      options:
        banner: "<%= global.ver.min %>"
      all:
        src: rootFile + ".css"
        dest: rootFile  + ".min.css"
      structure:
        src: structureFile + ".css"
        dest: structureFile  + ".min.css"
      theme:
        src: themeFile + ".css"
        dest: themeFile + ".min.css"
      fontawesome:
        src: "compiled/customfont/fontawesome.css"
        dest:"compiled/customfont/fontawesome.min.css"

    # config for grunt-contrib-compress
    compress: readCoffee "build/compress.coffee"

    sizereport:
      "Core":
        "Compressed stylesheet": [ rootFile + ".min.css" ]
        "Compressed javascript": [ rootFile + ".min.js" ]
      "Stylesheets":
        "structure": [structureFile  + ".min.css"]
        "theme": [themeFile + ".min.css"]
      "Custom font-awesome":
        "Stylesheet": [ "compiled/customfont/fontawesome.css" ]
        "TTF fonts": [ "compiled/customfont/fontawesome-webfont.ttf" ]
        "EOT fonts": [ "compiled/customfont/fontawesome-webfont.eot" ]
        "WOFF fonts": [ "compiled/customfont/fontawesome-webfont.woff" ]
      "Images":
        "Image files": [ "compiled/images" ]

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
  
  grunt.registerTask "zip", ["js","css","compress:zip"]

  # load the project's default tasks
  grunt.loadTasks "build/tasks"

  grunt.registerTask "coffee:watch", () ->
    done = @async()
    execSync = require "exec-sync"
    
    ManifestContent = require "./manifest_content.coffee"
    m = new ManifestContent("js.manifest",{ baseDir: "src" })
    files = m.list /\.coffee/
    cmd = """
    coffee -wbc -j compiled/umobi.coffee.js #{ files.join(" ") }
    """
    grunt.log.writeln("Running command:\n   #{cmd}")
    execSync(cmd)
    done()

  # set the default task.
  grunt.registerTask "default", ["coffeelint","js","css","qunit","sizereport"]
