
fs     = require "fs"
class ContentManifest

	filters: [ ]

	constructor: (file,@options) ->
		@rawContent = fs.readFileSync(file,"utf8")
		@list = @rawContent.split /\n/

	addFilter: (pattern,filter) -> @filters.push { pattern: pattern, filter: filter }

	compile: ->
		content = ""
		for item in @list
			for f in @filters
				if item.match f.pattern
					content += f.filter(item)
					break
		return content

module.exports = ContentManifest
