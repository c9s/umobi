###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['cs!umobi.core','cs!umobi.page'], ()->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    umobi.handleHashChange = (e) -> umobi.page.revealByHash(location.hash)

    $(window).on 'hashchange', (e) -> umobi.handleHashChange(e)

    class window.umobi.Navigator
      # url path helpers for use in relative url management
      # This scary looking regular expression parses an absolute URL or its relative
      # variants (protocol, site, document, query, and hash), into the various
      # components (protocol, host, path, query, fragment, etc that make up the
      # URL as well as some other commonly used sub-parts. When used with RegExp.exec()
      # or String.match, it parses the URL into a results array that looks like this:
      #
      #     [0]: http://jblas:password@mycompany.com:8080/mail/inbox?msg=1234&type=unread#msg-content
      #     [1]: http://jblas:password@mycompany.com:8080/mail/inbox?msg=1234&type=unread
      #     [2]: http://jblas:password@mycompany.com:8080/mail/inbox
      #     [3]: http://jblas:password@mycompany.com:8080
      #     [4]: http:
      #     [5]: //
      #     [6]: jblas:password@mycompany.com:8080
      #     [7]: jblas:password
      #     [8]: jblas
      #     [9]: password
      #    [10]: mycompany.com:8080
      #    [11]: mycompany.com
      #    [12]: 8080
      #    [13]: /mail/inbox
      #    [14]: /mail/
      #    [15]: inbox
      #    [16]: ?msg=1234&type=unread
      #    [17]: #msg-content
      #
      urlParseRE: /^\s*(((([^:\/#\?]+:)?(?:(\/\/)((?:(([^:@\/#\?]+)(?:\:([^:@\/#\?]+))?)@)?(([^:\/#\?\]\[]+|\[[^\/\]@#?]+\])(?:\:([0-9]+))?))?)?)?((\/?(?:[^\/\?#]+\/+)*)([^\?#]*)))?(\?[^#]+)?)(#.*)?/,

      # Abstraction to address xss (Issue #4787) by removing the authority in
      # browsers that auto	decode it. All references to location.href should be
      # replaced with a call to this method so that it can be dealt with properly here
      getLocation: ( url ) ->
        uri = if url then this.parseUrl( url ) else location
        hash = @parseUrl( url or location.href ).hash

          # mimic the browser with an empty string when the hash is empty
        hash = if hash is "#" then "" else hash

        # Make sure to parse the url or the location object for the hash because using location.hash
        # is autodecoded in firefox, the rest of the url should be from the object (location unless
        # we're testing) to avoid the inclusion of the authority
        return uri.protocol + "//" + uri.host + uri.pathname + uri.search + hash

      parseLocation: () -> @parseUrl( @getLocation() )

      # Parse a URL into a structure that allows easy access to
      # all of the URL components by name.
      parseUrl: ( url ) ->
        # If we're passed an object, we'll assume that it is
        #	 a parsed url object and just return it back to the caller.
        return url if $.type( url ) is "object"

        matches = path.urlParseRE.exec( url or "" ) or []

        # Create an object that allows the caller to access the sub-matches
        # by name. Note that IE returns an empty string instead of undefined,
        # like all other browsers do, so we normalize everything so its consistent
        # no matter what browser we're running on.
        data =
          href:         matches[  0 ] or ""
          hrefNoHash:   matches[  1 ] or ""
          hrefNoSearch: matches[  2 ] or ""
          domain:       matches[  3 ] or ""
          protocol:     matches[  4 ] or ""
          doubleSlash:  matches[  5 ] or ""
          authority:    matches[  6 ] or ""
          username:     matches[  8 ] or ""
          password:     matches[  9 ] or ""
          host:         matches[ 10 ] or ""
          hostname:     matches[ 11 ] or ""
          port:         matches[ 12 ] or ""
          pathname:     matches[ 13 ] or ""
          directory:    matches[ 14 ] or ""
          filename:     matches[ 15 ] or ""
          search:       matches[ 16 ] or ""
          hash:         matches[ 17 ] or ""
        return data

      # Turn relPath into an asbolute path. absPath is
      # an optional absolute path which describes what
      # relPath is relative to.
      makePathAbsolute: ( relPath, absPath ) ->
        return relPath if relPath and relPath.charAt( 0 ) is "/"

        relPath = relPath or ""
        absPath = if absPath then absPath.replace( /^\/|(\/[^\/]*|[^\/]+)$/g, "" ) else ""

        absStack = if absPath then absPath.split( "/" ) else []
        relStack = relPath.split( "/" )

        for d in relStack
          switch d
            when "." then 1
            when ".."
              if absStack.length
                absStack.pop()
            else absStack.push( d )
        return "/" + absStack.join( "/" )
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return
###
//>>excludeEnd("umobiBuildExclude")
###
