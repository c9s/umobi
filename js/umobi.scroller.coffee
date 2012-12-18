###
//>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
###
define ['jquery','cs!umobi.core','cs!u'], ($,umobi,u) ->
  ###
  //>>excludeEnd("umobiBuildExclude")
  ###
  (->
    debug = window.console and false

    u.ready ->
      # TODO: range slider need this.
      document.body.addEventListener('touchmove', ((e) ->
        # This prevents native scrolling from happening.
        e.preventDefault()
      ), false)

    class Scroller
      snapBoundary: 80
      snapDuration: 500
      constructor: (@element) ->

        # first touch offset Y from touchstart event.
        @animationIndex = 1
        @startTouchY = 0
        @globalStyleSheet = document.styleSheets[document.styleSheets.length-1]

        @$el = $(@element)
        @uEl = u(@element)
        @viewportElement = @element.parentNode

        # last touch offset Y from touchmove event.
        @lastTouchY          = undefined
        @prevTouchY          = undefined
        @contentStartOffsetY = 0
        self = this
        @element.addEventListener 'touchstart', this, false


        # @element.addEventListener 'touchmove', this, false
        # This seems faster for dispatching (by using native dispatcher?)
        onTouchMove = self.onTouchMove
        @element.addEventListener 'touchmove', (e) -> onTouchMove.call(self,e)

        @element.addEventListener 'touchend', this, false

      ###
      HandleEvent
      
      As the interface is marked with the [function] flag, all JavaScript
      Function objects automatically implement this interface. Calling the
      handleEvent() method on such an implementation automatically invokes
      the function.
      
      http://www.w3.org/TR/DOM-Level-2-Events/events.html#Events-EventListener
      ###
      handleEvent: (e) ->
        switch e.type
          when "touchstart" then @onTouchStart(e)
          when "touchend" then @onTouchEnd(e)

      onTouchStart: (e) ->
        @stopMomentum()
        @startTouchY = e.touches[0].clientY
        @startTouchTime = (new Date).getTime()
        @contentStartOffsetY = @getContentOffsetY()

        console.log 'onTouchStart', {
          startTouchY: @startTouchY
          contentStartOffsetY: @contentStartOffsetY
        } if debug

      onTouchMove: (e) ->
        return if not @isDragging

        currentY    = e.touches[0].clientY

        @prevTouchY = @lastTouchY
        @lastTouchY = currentY

        return if @viewportHeight() > @contentHeight()

        deltaY      = currentY - @startTouchY
        newY        = deltaY   + @contentStartOffsetY

        ###
        //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
        ###
        console.log 'onTouchMove', {
          touchY: currentY
          deltaY: deltaY
          newY: newY
          contentStartOffsetY: @contentStartOffsetY
          # transform: @getCurrentTransform()
        } if debug
        ###
        //>>excludeEnd("umobiBuildExclude")
        ###
        
        d = @getTouchDirection()
        if d is 1
          # top boundary
          newY = @snapBoundary if newY > @snapBoundary
        else if d is -1
          # bottom boundary
          contentHeight = @contentHeight()
          viewportHeight = @viewportHeight()
          newY = - contentHeight + (viewportHeight - @snapBoundary) \
            if (contentHeight + newY + @snapBoundary) < viewportHeight

        # @startTouchY = currentY
        # return
        @animateTo(newY)
        @contentLastOffsetY = newY

      onTouchEnd: (e) ->
        console.log 'onTouchEnd',e if debug

        if @isDragging()
          if @shouldStartMomentum()
            @startMomentum()
          else
            @snapToBounds()


      # delta > 0 , scrolling down
      # delta == 0, scrolling stop
      # detal < 0 , scrolling up
      getTouchDirection: () ->
        delta = (@lastTouchY - @prevTouchY)
        return 1 if delta > 0
        return 0 if delta is 0
        return -1 if delta < 0

      getCurrentTransform: () ->
        style = document.defaultView.getComputedStyle(@element, null)
        new WebKitCSSMatrix(style.webkitTransform)

      getContentOffsetY: () -> @getCurrentTransform().m42

      isDragging: () -> true

      animateTo: (offsetY) ->
        @contentOffsetY = offsetY

        # We use webkit-transforms with translate3d because these animations
        # will be hardware accelerated, and therefore significantly faster
        # than changing the top value.
        @element.style.webkitTransform = 'translate3d(0, ' + offsetY + 'px, 0)'

      getEndVelocity: -> (@contentLastOffsetY - @contentStartOffsetY) / ((new Date).getTime() - @startTouchTime)

      isDecelerating: -> true

      cubicBezierAnimateTo: (time,newY) ->
        @element.style.webkitTransition = '-webkit-transform ' + time + 'ms cubic-bezier(0.33, 0.66, 0.66, 1)'
        @element.style.webkitTransform = 'translate3d(0,' + newY + 'px, 0)'
        @contentOffsetY = newY

      contentHeight: -> u(@element).height()

      viewportHeight: -> u(@viewportElement).height()

      overBottomSnapLimit: (newY) ->
        return ( @viewportHeight() - (@contentHeight() + newY)) >= @snapBoundary

      shouldStartMomentum: ->
        m = @calculateMomentum()
        return false if m.velocity < 0.2 and m.newY > 0
        return false if @overBottomSnapLimit(m.newY)

        # return true if m.newY > @snapBoundary
        # @lastTouchY
        return true

      # Calculate the movement properties. Implement getEndVelocity using the
      # start and end position / time.
      calculateMomentum: () ->
        velocity = @getEndVelocity()
        acceleration = if velocity < 0 then 0.0005 else -0.0005
        displacement = - (velocity * velocity) / (2 * acceleration)
        time = - velocity / acceleration
        newY = @contentOffsetY + displacement
        return {
          velocity: velocity
          acceleration: acceleration
          displacement: displacement
          time: time
          newY: newY
        }

      startMomentum: () ->
        m = @calculateMomentum()
        if m.newY > 0
          # first generate a css keyframe to animate to top boundery
          # then snap it to bounds.
          name = 'snaptobounds' + (@animationIndex++)
          frames = []
          time = m.time * 0.6
          newY = if m.newY > @snapBoundary then @snapBoundary else m.newY
          frames.push {
            time: time * 0.2
            transform: 'translate3d(0,' + newY + 'px,0)'
          }
          frames.push {
            time: time
            transform: 'translate3d(0,' + 0 + 'px,0)'
          }

          framecss = @generateCSSKeyframes(frames,name,time)
          @globalStyleSheet.insertRule(framecss, 0)
          @element.style.webkitAnimation = name + " " + time + "ms cubic-bezier(0.33,0.66,0.66,1)"
          @element.style.webkitAnimationPlayState = name ? "running" : "paused"
          console.log 'Playing snaptobounds animation', framecss if debug
          normalEnd = (e) =>
            @element.removeEventListener("webkitAnimationEnd", normalEnd, false)
            @globalStyleSheet.deleteRule(0)
            @element.style.webkitAnimation = 'none'
            @element.style.webkitTransition = ''
            @animateTo(0)
            # @stopMomentum()
            # @element.style.webkitAnimationPlayState = "paused"
            # @element.style.webkitTransform = "translate3d(0,0,0)"
            # @contentOffsetY = 0
            # @contentStartOffsetY = 0
          @element.addEventListener("webkitAnimationEnd", normalEnd, false)
          return


        # Set up the transition and execute the transform. Once you implement this
        # you will need to figure out an appropriate time to clear the transition
        # so that it doesn’t apply to subsequent scrolling.
        # @element.style.webkitTransition = '-webkit-transform ' + time + 'ms cubic-bezier(0.33, 0.66, 0.66, 1)'
        console.log "startMomentum", m if debug
        @cubicBezierAnimateTo(m.time,m.newY)

      stopMomentum: () ->
        if @isDecelerating()
          transform = @getCurrentTransform()
          # Clear the active transition so it doesn’t apply to our next transform.
          @element.style.webkitTransition = ''
          # Set the element transform to where it is right now.
          @animateTo(transform.m42)

      snapToBounds: () ->
        offsetY = @getContentOffsetY()
        d = @getTouchDirection()
        console.log d
        if d is -1 and @overBottomSnapLimit(offsetY)
          contentHeight = @contentHeight()
          parentHeight  = @viewportHeight()
          @cubicBezierAnimateTo(@snapDuration, (parentHeight - contentHeight) )
        else if d is 1
          @cubicBezierAnimateTo(@snapDuration,0)

      # keyframes [array]
      # name [string]
      # time, duration [microseconds]
      # offset
      generateCSSKeyframes: (keyframes, name, time, offset) ->
        lines = [ '@-webkit-keyframes ' + name + ' {' ]
        keyframes.forEach (keyframe) ->
          percent = (keyframe.time / time) * 100
          frame = Math.floor(percent) + '% { '
          frame += '-webkit-transform: ' + keyframe.transform + ';'
          frame += '-webkit-transition: ' + keyframe.transition + ';' if keyframe.transition
          frame += '}'
          # D&&D(frame)
          lines.push frame
        lines.push '}'
        return lines.join '\n'
    umobi.scroller = {}
    umobi.scroller.create = (element) -> new Scroller(element)
  )()
  ###
  //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
  ###
  return umobi.scroller
###
//>>excludeEnd("umobiBuildExclude")
###
