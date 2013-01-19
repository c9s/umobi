requirejs = require "requirejs"
path      = require "path"
fs        = require "fs"
CoffeeScript    = require "coffee-script"
ManifestContent = require "../../manifest_content.coffee"
ManifestTag     = require "../../manifest_tag.coffee"

module.exports = (grunt) ->
  config = grunt.config.get("global")
  helpers = config.helpers
  grunt.registerTask "js:compile", ->
    require       = grunt.config.get("js").require
    global_config = grunt.config.get("global")
    
    # pull the includes together using require js
    # grunt.log.writeln "requriejs optimizing..."
    # requirejs.optimize require

    grunt.log.header "Compiling js from js.manifest..."
    manifest = new ManifestContent("js.manifest",{ baseDir: "src" })
    manifest.addFilter /\.js$/,  (file) -> fs.readFileSync(file,"utf8")
    manifest.addFilter /\.coffee/, (file) -> CoffeeScript.compile(fs.readFileSync(file,"utf8"))
    fs.writeFileSync(require.out,manifest.compile() )
    grunt.log.ok "js.manifest compilation success."

    grunt.log.header "Compiling js header for developement..."
    mtag = new ManifestTag("js.manifest",{ baseDir: "src", baseUrl: "src" })
    grunt.log.writeln mtag.compile()
    
    # replace the version with the value in version.text
    grunt.log.header "Writing version info..."
    grunt.file.copy require.out, require.out,
      process: (fileContents) ->
        fileContents.replace /__version__/, "\"" + global_config.ver.official + "\""


  grunt.registerTask "js:cleanup", "compile and minify the js", ->
    require = grunt.config.get("js").require
    # remove the requirejs compile output
    fs.unlink require.out
  
  # NOTE custom dasks don't accept dependencies so we alias
  grunt.registerTask "js", [
    "config:async"
    "js:compile"
    "concat:js"
    "uglify"
    "js:cleanup"
  ]

