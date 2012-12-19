
define [], ->

  String::toCapitalCase = -> @charAt(0).toUpperCase() + @substr(1)

  String::toCamelCase = () ->
    (@toWords().map (p) -> p.toCapitalCase() ).join('')

  String::toLowerCamelCase = () ->
    [first,rest...] = @toWords()
    first + (rest.map (p) -> p.toCapitalCase() ).join('')

  String::toWords = () -> @split(/[-_,\.]+/)

  String::toDashCase = () ->
    @replace( /([A-Z])/g , (v) -> '-' + v.toLowerCase() ).replace( /^-/, '')

