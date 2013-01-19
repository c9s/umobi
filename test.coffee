

fs = require "fs"
coffee = require "coffee-script"

ManifestContent = require "./manifest_content.coffee"
manifest = new ManifestContent("js.manifest",{ baseDir: "src" })
manifest.addFilter /\.js$/,  (file) -> fs.readFileSync(file,"utf8")
manifest.addFilter /\.coffee/, (file) -> coffee.compile(fs.readFileSync(file,"utf8"),{ bare: true })
jscontent = manifest.compile()

ManifestTag = require "./manifest_tag.coffee"
mtag = new ManifestTag("js.manifest",{ baseDir: "src", baseUrl: "../src", newline: true })
mtag.addType /\.js$/, "text/javascript"
mtag.addType /\.coffee$/, "text/coffeescript"
mtag.addType /\.ls$/, "text/livescript"
jstags = mtag.compile()
console.log jstags

# console.log jscontent
