fs     = require "fs"

# Manifest tag generator
class ManifestTag
  contentList: []
  options: {}
  types: []

  constructor: (file,@options) ->
    @rawContent = fs.readFileSync(file,"utf8")
    @contentList = @rawContent.split /\n/
    @addType /\.js$/, "text/javascript"
    @addType /\.coffee$/, "text/coffeescript"
    @addType /\.ls$/, "text/livescript"
    @addType /\.html$/, "text/html"

  addType: (pattern,type) -> @types.push { pattern: pattern, type: type }

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
      file = @options.baseDir + "/" + file if @options.baseDir

      unless fs.existsSync(file)
        console.warn "File #{ file } does not exist."
        continue

      for t in @types
        if file.match t.pattern
          url = if @options.baseUrl then @options.baseUrl + "/" + line \
            else line
          content += """
          <script type="#{ t.type }" src="#{ url }"></script>
          """
          break
      content += "\n" if @options.newline
    return content

module.exports = ManifestTag
