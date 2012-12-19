
define [], ->
  String::toCamelCase = () ->
    (@toWords().map (p) -> p.charAt(0).toUpperCase() + p.substr(1)).join('')

  String::toLowerCamelCase = () ->
    [first,rest...] = @toWords()
    first + (rest.map (p) -> p.charAt(0).toUpperCase() + p.substr(1)).join('')

  String::toWords = () -> @split('-')

  String::toDashCase = () ->
    @replace( /([A-Z])/g , (v) -> '-' + v.toLowerCase() ).replace( /^-/, '')

