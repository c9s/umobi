
coffee = require "coffee-script"
fs     = require "fs"

class JsManifest
	constructor: (file,@options) ->
		@rawContent = fs.readFileSync(file,"utf8")
		@list = @rawContent.split /\n/
		for item in @list
			console.log item
	jsFiles: ->
		files = []
		for item in @list
			files.push item if item.match /\.js$/
		return files
	coffeeFiles: ->
		files = []
		for item in @list
			files.push item if item.match /\.coffee$/
		return files
	compile: ->
		jsFiles = @jsFiles()
		coffeeFiles = @coffeeFiles()
		coffeeContent = ""
		jsContent = ""
		jsFromCoffee = ""
		for f in jsFiles
			jsContent += fs.readFileSync(f)
		for f in coffeeFiles
			jsFromCoffee += "// File: " + f
			jsFromCoffee += coffee.compile(fs.readFileSync(f,"utf8"))
		return jsContent + jsFromCoffee

module.exports = JsManifest
