###
To inner wrap a link with ui-btn classes:

<a href="index.html" data-role="button" data-corners="true"
  data-shadow="true" data-iconshadow="true" data-wrapperels="span"
  data-theme="c" class="ui-btn ui-shadow ui-btn-corner-all ui-btn-up-c">
    <span class="ui-btn-inner ui-btn-corner-all">
      <span class="ui-btn-text">Link button</span>
    </span>
</a>
###
u.ready ->
  for link in document.links
    ulink = u(link)
    if not ulink.data('role')
      # initialize <a> as a normal link
      ulink.addClass('ui-link')
    ulink.click (e) ->
      href = ulink.attr("href")

      # just reveal the page if the href only contains #hash
      umobi.page.revealByHash(href) if /^#\w+/

      regs = href.match /(#\w+)/
      hash = if regs then regs[1] else "#index"

      if ulink.data("ajax")
        # XXX: show loading indicator here.
        e.preventDefault()
        $.ajax
          url: href
          dataType: "html"
          success: (html) ->
            body = document.createElement("body")
            body.innerHTML = html
            $body = $(body)

            # XXX: injects all pages into current document.
            $page = $body.find(hash)
            if not $page.get(0)
              $page = $body.find('[data-role="page"]').first()
            $(document.body).append($page)
          error: (err) ->
            console.error "error",err
        return false
