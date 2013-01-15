// Generated by CoffeeScript 1.4.0
(function() {

  define(["jquery", "cs!umobi.core", "cs!u"], function() {
    var Scroller, debug;
    debug = window.console && true;
    Scroller = (function() {

      Scroller.prototype.snapBoundary = 80;

      Scroller.prototype.snapDuration = 500;

      function Scroller(element) {
        var onTouchMove, self;
        this.element = element;
        this.animationIndex = 1;
        this.startTouchY = 0;
        this.globalStyleSheet = document.styleSheets[document.styleSheets.length - 1];
        this.$el = $(this.element);
        this.uEl = u(this.element);
        this.viewportElement = this.element.parentNode;
        this.lastTouchY = void 0;
        this.prevTouchY = void 0;
        this.contentStartOffsetY = 0;
        self = this;
        this.element.addEventListener("touchstart", this, false);
        onTouchMove = self.onTouchMove;
        this.element.addEventListener("touchmove", function(e) {
          return onTouchMove.call(self, e);
        });
        this.element.addEventListener("touchend", this, false);
      }

      /*
          HandleEvent
          
          As the interface is marked with the [function] flag, all JavaScript
          Function objects automatically implement this interface. Calling the
          handleEvent() method on such an implementation automatically invokes
          the function.
          
          http://www.w3.org/TR/DOM-Level-2-Events/events.html#Events-EventListener
      */


      Scroller.prototype.handleEvent = function(e) {
        switch (e.type) {
          case "touchstart":
            return this.onTouchStart(e);
          case "touchend":
            return this.onTouchEnd(e);
        }
      };

      Scroller.prototype.onTouchStart = function(e) {
        this.stopMomentum();
        this.startTouchY = e.touches[0].clientY;
        this.startTouchTime = (new Date).getTime();
        this.contentStartOffsetY = this.getCurrentContentOffsetY();
        this.contentLastOffsetY = this.contentStartOffsetY;
        if (debug)  
          return console.log('onTouchStart', {
            startTouchY: this.startTouchY,
            contentStartOffsetY: this.contentStartOffsetY
          });
      };

      Scroller.prototype.onTouchMove = function(e) {
        var contentHeight, currentY, d, deltaY, newY, viewportHeight;
        this.prevTouchY = this.lastTouchY;
        this.lastTouchY = currentY = e.touches[0].clientY;
        if (!this.isDragging)  
          return;
        if (this.viewportHeight() > this.contentHeight())  
          return;
        deltaY = currentY - this.startTouchY;
        newY = deltaY + this.contentStartOffsetY;
        /*
              //>>excludeStart("umobiBuildExclude", pragmas.umobiBuildExclude)
        */

        if (debug)  
          console.log('onTouchMove', {
            touchY: currentY,
            deltaY: deltaY,
            newY: newY,
            contentStartOffsetY: this.contentStartOffsetY
          });
        /*
              //>>excludeEnd("umobiBuildExclude")
        */

        d = this.getTouchDirection();
        if (d === 1) {
          if (newY > this.snapBoundary)  
            newY = this.snapBoundary; 
        } else if (d === -1) {
          contentHeight = this.contentHeight();
          viewportHeight = this.viewportHeight();
          if ((contentHeight + newY + this.snapBoundary) < viewportHeight)  
            newY = -contentHeight + (viewportHeight - this.snapBoundary); 
        }
        this.animateTo(newY);
        return this.contentLastOffsetY = newY;
      };

      Scroller.prototype.onTouchEnd = function(e) {
        if (debug)  
          console.log('onTouchEnd', e);
        if (this.isDragging()) {
          if (this.shouldStartMomentum()) {
            return this.startMomentum(); 
          } else {
            return this.snapToBounds();
          } 
        }
      };

      Scroller.prototype.getTouchDirection = function() {
        var delta;
        delta = this.lastTouchY - this.prevTouchY;
        if (delta > 0)  
          return 1;
        if (delta === 0)  
          return 0;
        if (delta < 0)  
          return -1;
      };

      Scroller.prototype.getCurrentTransform = function() {
        var style;
        style = document.defaultView.getComputedStyle(this.element, null);
        return new WebKitCSSMatrix(style.webkitTransform);
      };

      Scroller.prototype.getCurrentContentOffsetY = function() {
        return this.getCurrentTransform().m42;
      };

      Scroller.prototype.isDragging = function() {
        return this.lastTouchY !== this.prevTouchY;
      };

      Scroller.prototype.animateTo = function(offsetY) {
        this.contentOffsetY = offsetY;
        return this.element.style.webkitTransform = 'translate3d(0, ' + offsetY + 'px, 0)';
      };

      Scroller.prototype.getEndVelocity = function() {
        return (this.contentLastOffsetY - this.contentStartOffsetY) / ((new Date).getTime() - this.startTouchTime);
      };

      Scroller.prototype.cubicBezierAnimateTo = function(time, newY) {
        this.element.style.webkitTransition = '-webkit-transform ' + time + 'ms cubic-bezier(0.33, 0.66, 0.66, 1)';
        this.element.style.webkitTransform = 'translate3d(0,' + newY + 'px, 0)';
        return this.contentOffsetY = newY;
      };

      Scroller.prototype.contentHeight = function() {
        return u(this.element).height();
      };

      Scroller.prototype.viewportHeight = function() {
        return u(this.viewportElement).height();
      };

      Scroller.prototype.overBottomSnapLimit = function(newY) {
        return (this.viewportHeight() - (this.contentHeight() + newY)) >= this.snapBoundary;
      };

      Scroller.prototype.shouldStartMomentum = function() {
        var m;
        m = this.calculateMomentum();
        if (m.velocity < 0.2 && m.newY > 0)  
          return false;
        if (this.overBottomSnapLimit(m.newY))  
          return false;
        return true;
      };

      Scroller.prototype.calculateMomentum = function() {
        var acceleration, displacement, newY, time, velocity;
        velocity = this.getEndVelocity();
        acceleration = velocity < 0 ? 0.0005 : -0.0005;
        displacement = -(velocity * velocity) / (2 * acceleration);
        time = -velocity / acceleration;
        newY = this.contentOffsetY + displacement;
        return {
          velocity: velocity,
          acceleration: acceleration,
          displacement: displacement,
          time: time,
          newY: newY
        };
      };

      Scroller.prototype.startMomentum = function() {
        var d, framecss, frames, m, name, newY, normalEnd, time,
          _this = this;
        d = this.getTouchDirection();
        m = this.calculateMomentum();
        if (d === 1 && m.newY > 0) {
          name = 'snaptobounds' + (this.animationIndex++);
          frames = [];
          time = m.time * 0.6;
          newY = m.newY > this.snapBoundary ? this.snapBoundary : m.newY;
          frames.push({
            time: time * 0.2,
            transform: 'translate3d(0,' + newY + 'px,0)'
          });
          frames.push({
            time: time,
            transform: 'translate3d(0,' + 0 + 'px,0)'
          });
          framecss = this.generateCSSKeyframes(frames, name, time);
          this.globalStyleSheet.insertRule(framecss, 0);
          this.element.style.webkitAnimation = name + " " + time + "ms cubic-bezier(0.33,0.66,0.66,1)";
          this.element.style.webkitAnimationPlayState = name != null ? name : {
            "running": "paused"
          };
          if (debug)  
            console.log('Playing snaptobounds animation', framecss);
          normalEnd = function(e) {
            _this.element.removeEventListener("webkitAnimationEnd", normalEnd, false);
            _this.globalStyleSheet.deleteRule(0);
            _this.element.style.webkitAnimation = 'none';
            _this.element.style.webkitTransition = '';
            _this.animateTo(0);
            return _this.contentLastOffsetY = 0;
          };
          this.element.addEventListener("webkitAnimationEnd", normalEnd, false);
          return; 
        }
        if (debug)  
          console.log("startMomentum", m);
        return this.cubicBezierAnimateTo(m.time, m.newY);
      };

      /*
          TODO:
          When touch starts, stopMomentum will be called if
          the transition is decelerating.
      */


      Scroller.prototype.isDecelerating = function() {
        return true;
      };

      Scroller.prototype.stopMomentum = function() {
        var transform;
        if (this.isDecelerating()) {
          transform = this.getCurrentTransform();
          this.element.style.webkitTransition = '';
          return this.animateTo(transform.m42); 
        }
      };

      Scroller.prototype.snapToBounds = function() {
        var contentHeight, d, offsetY, parentHeight;
        offsetY = this.getCurrentContentOffsetY();
        d = this.getTouchDirection();
        if (d === -1 && this.overBottomSnapLimit(offsetY)) {
          contentHeight = this.contentHeight();
          parentHeight = this.viewportHeight();
          return this.cubicBezierAnimateTo(this.snapDuration, parentHeight - contentHeight); 
        } else if (d === 1)  
          return this.cubicBezierAnimateTo(this.snapDuration, 0);
      };

      Scroller.prototype.generateCSSKeyframes = function(keyframes, name, time, offset) {
        var lines;
        lines = ['@-webkit-keyframes ' + name + ' {'];
        keyframes.forEach(function(keyframe) {
          var frame, percent;
          percent = (keyframe.time / time) * 100;
          frame = Math.floor(percent) + '% { ';
          frame += '-webkit-transform: ' + keyframe.transform + ';';
          if (keyframe.transition)  
            frame += '-webkit-transition: ' + keyframe.transition + ';';
          frame += '}';
          return lines.push(frame);
        });
        lines.push('}');
        return lines.join('\n');
      };

      return Scroller;

    })();
    umobi.scroller = {};
    umobi.scroller.create = function(element) {
      return new Scroller(element);
    };
    return umobi.scroller;
  });

}).call(this);