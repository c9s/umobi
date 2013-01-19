fs     = require "fs"
class ContentManifest
	filters: [ ]
	finalizeFilters: []
	contentList: []

	constructor: (file,@options) ->
		@rawContent = fs.readFileSync(file,"utf8")
		@contentList = @rawContent.split /\n/


	###
	A filter is registered with a pattern and a callback, 
	The callback takes a file path and should returns filtered content.
	###
	addFilter: (pattern,filter) -> @filters.push { pattern: pattern, filter: filter }

	### 
	A finalize filter takes content in string and returns filtered content.
	###
	addFinalizeFilter: (filter) -> @finalizeFilters.push filter

	###
	Compile manifest to content through these registered filters.
	returns content string.
	###
	compile: ->
		content = ""
		for line in @contentList
			# strip comments
			continue unless line
			continue if line.match /^\s*#/
			file = line.replace /#.*/, ""

			unless fs.existsSync(file)
				console.warn "File #{ file } does not exist."
				continue

			console.log "Compiling #{ file }..."

			for f in @filters
				if file.match f.pattern
					content += f.filter(file)
					break
		for f in @finalizeFilters
			content = f(content)
		return content

module.exports = ContentManifest
