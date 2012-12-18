path = require("path")
fs = require("fs")
execSync = require("exec-sync")
module.exports = (grunt) ->

  cssmin = {}
  dirs =
    output: "compiled"
    temp: "tmp"

  # this will change for the deploy target to include version information
  outputPath = (name) -> path.join(dirs.output, name)

  verOfficial = grunt.file.read("version.txt").replace(/\n/, "")

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
  
  # TODO again, I'd like to use grunt params but I'm not sure
  #      how to get that working with a custom task with deps
  theme = process.env.THEME or "default"
  
  # Project configuration.
  grunt.config.init
    jshint:
      options:
        curly: true
        eqeqeq: true
        
        # (function(){})() seems acceptable
        immed: false
        latedef: true
        newcap: true
        noarg: true
        sub: true
        undef: true
        boss: true
        eqnull: true
        browser: true

      globals:
        jQuery: true
        $: true
        
        # qunit globals
        # TODO would be nice to confine these to test files
        module: true
        ok: true
        test: true
        asyncTest: true
        same: true
        start: true
        stop: true
        expect: true
        
        # require js global
        define: true
        require: true

    
    # TODO add test files here once we can specify different configs for
    #      different globs
    # lint:
    #  files: ["js/**/*.mobile.*.js", "js/*/*.js"]

    coffeelint:
      app: ['js/*.coffee']
    coffeelintOptions:
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
    cssmin: `undefined`
    
    # JS config, mostly the requirejs configuration
    js:
      require:
        baseUrl: "js"
        name: "umobi"
        exclude: [
          "jquery"
          "cs"
          "coffee-script"
          "depend"
          "text"
          "text!../version.txt"
        ]
        paths:
          "cs": "cs"
          "coffee-script": "coffee-script"
          "jquery":"jquery"
        # use bare option for coffee-script compiler,
        # this remove the function wrapper from coffee-script.
        CoffeeScript: { bare: true }
        out: rootFile + ".compiled.js"
        pragmas: { umobiBuildExclude: true }
        wrap:
          startFile: 'build/wrap.start'
          endFile: 'build/wrap.end'
        findNestedDependencies: true
        skipModuleInsertion: true
        optimize: "none"
    
    # CSS config, mostly the requirejs configuration
    css:
      theme: process.env.THEME or "default"
      themeFile: themeFile
      require:
        all:
          cssIn: "css/themes/default/umobi.css"
          optimizeCss: "standard.keepComments.keepLines"
          baseUrl: "."
          out: rootFile + ".compiled.css"
        structure:
          cssIn: "css/structure/umobi.structure.css"
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
  
  # CSSMIN configuration
  cssmin[rootFile + ".min.css"] = ["<%= global.ver.min %>", rootFile + ".css"]
  cssmin[structureFile + ".min.css"] = ["<%= global.ver.min %>", structureFile + ".css"]
  cssmin[themeFile + ".min.css"] = ["<%= global.ver.min %>", themeFile + ".css"]
  grunt.config.set "cssmin", cssmin
  
  # set the default task.
  grunt.registerTask "default", "coffeelint"

  grunt.registerTask "sass", "compile sass files into css file", ->
    grunt.log.writeln "sass --update css"
    execSync "sass --update css"

  
  # csslint and cssmin tasks
  grunt.loadNpmTasks "grunt-css"
  
  # authors task
  grunt.loadNpmTasks "grunt-git-authors"
  grunt.loadNpmTasks "grunt-junit"
  grunt.loadNpmTasks "grunt-coffeelint"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-qunit"
  
  
  # Ease of use aliases for users who want the zip and docs
  grunt.registerTask "docs", "js css legacy_tasks:docs"
  grunt.registerTask "zip", "js css legacy_tasks:zip"

  grunt.event.on 'qunit.spawn', (url) ->
    grunt.log.ok("Running test: " + url)
  
  # load the project's default tasks
  grunt.loadTasks "build/tasks"
