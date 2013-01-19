
fs     = require "fs"
class ContentManifest

	filters: [ ]
	finalizeFilters: []

	constructor: (file,@options) ->
		@rawContent = fs.readFileSync(file,"utf8")
		@list = @rawContent.split /\n/


	###
	A filter is registered with a pattern and a callback, 
	The callback takes a file path and should returns filtered content.
	###
	addFilter: (pattern,filter) -> @filters.push { pattern: pattern, filter: filter }

	### 
	A finalize filter takes content in string and returns filtered content.
	###
	addFinalizeFilter: (filter) -> @finalizeFilters.push filter

	compile: ->
		content = ""
		for item in @list
			# strip comments
			continue unless item
			continue if item.match /^\s*#/
			item.replace /#.*/,""
			unless fs.existsSync(f)
				console.warn "File #{ f } does not exist."
				continue

			for f in @filters
				if item.match f.pattern
					content += f.filter(item)
					break
		for f in @finalizeFilters
			content = f(content)
		return content

module.exports = ContentManifest
