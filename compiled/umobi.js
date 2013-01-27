/**
 * MIT License, Copyright 2012 Yo-An Lin <cornelius.howl@gmail.com>
 * http://github.com/c9s/umobi
 * 
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
/*!
 * jQuery hashchange event - v1.3 - 7/21/2010
 * http://benalman.com/projects/jquery-hashchange-plugin/
 * 
 * Copyright (c) 2010 "Cowboy" Ben Alman
 * Dual licensed under the MIT and GPL licenses.
 * http://benalman.com/about/license/
 */

// Script: jQuery hashchange event
//
// *Version: 1.3, Last updated: 7/21/2010*
// 
// Project Home - http://benalman.com/projects/jquery-hashchange-plugin/
// GitHub       - http://github.com/cowboy/jquery-hashchange/
// Source       - http://github.com/cowboy/jquery-hashchange/raw/master/jquery.ba-hashchange.js
// (Minified)   - http://github.com/cowboy/jquery-hashchange/raw/master/jquery.ba-hashchange.min.js (0.8kb gzipped)
// 
// About: License
// 
// Copyright (c) 2010 "Cowboy" Ben Alman,
// Dual licensed under the MIT and GPL licenses.
// http://benalman.com/about/license/
// 
// About: Examples
// 
// These working examples, complete with fully commented code, illustrate a few
// ways in which this plugin can be used.
// 
// hashchange event - http://benalman.com/code/projects/jquery-hashchange/examples/hashchange/
// document.domain - http://benalman.com/code/projects/jquery-hashchange/examples/document_domain/
// 
// About: Support and Testing
// 
// Information about what version or versions of jQuery this plugin has been
// tested with, what browsers it has been tested in, and where the unit tests
// reside (so you can test it yourself).
// 
// jQuery Versions - 1.2.6, 1.3.2, 1.4.1, 1.4.2
// Browsers Tested - Internet Explorer 6-8, Firefox 2-4, Chrome 5-6, Safari 3.2-5,
//                   Opera 9.6-10.60, iPhone 3.1, Android 1.6-2.2, BlackBerry 4.6-5.
// Unit Tests      - http://benalman.com/code/projects/jquery-hashchange/unit/
// 
// About: Known issues
// 
// While this jQuery hashchange event implementation is quite stable and
// robust, there are a few unfortunate browser bugs surrounding expected
// hashchange event-based behaviors, independent of any JavaScript
// window.onhashchange abstraction. See the following examples for more
// information:
// 
// Chrome: Back Button - http://benalman.com/code/projects/jquery-hashchange/examples/bug-chrome-back-button/
// Firefox: Remote XMLHttpRequest - http://benalman.com/code/projects/jquery-hashchange/examples/bug-firefox-remote-xhr/
// WebKit: Back Button in an Iframe - http://benalman.com/code/projects/jquery-hashchange/examples/bug-webkit-hash-iframe/
// Safari: Back Button from a different domain - http://benalman.com/code/projects/jquery-hashchange/examples/bug-safari-back-from-diff-domain/
// 
// Also note that should a browser natively support the window.onhashchange 
// event, but not report that it does, the fallback polling loop will be used.
// 
// About: Release History
// 
// 1.3   - (7/21/2010) Reorganized IE6/7 Iframe code to make it more
//         "removable" for mobile-only development. Added IE6/7 document.title
//         support. Attempted to make Iframe as hidden as possible by using
//         techniques from http://www.paciellogroup.com/blog/?p=604. Added 
//         support for the "shortcut" format $(window).hashchange( fn ) and
//         $(window).hashchange() like jQuery provides for built-in events.
//         Renamed jQuery.hashchangeDelay to <jQuery.fn.hashchange.delay> and
//         lowered its default value to 50. Added <jQuery.fn.hashchange.domain>
//         and <jQuery.fn.hashchange.src> properties plus document-domain.html
//         file to address access denied issues when setting document.domain in
//         IE6/7.
// 1.2   - (2/11/2010) Fixed a bug where coming back to a page using this plugin
//         from a page on another domain would cause an error in Safari 4. Also,
//         IE6/7 Iframe is now inserted after the body (this actually works),
//         which prevents the page from scrolling when the event is first bound.
//         Event can also now be bound before DOM ready, but it won't be usable
//         before then in IE6/7.
// 1.1   - (1/21/2010) Incorporated document.documentMode test to fix IE8 bug
//         where browser version is incorrectly reported as 8.0, despite
//         inclusion of the X-UA-Compatible IE=EmulateIE7 meta tag.
// 1.0   - (1/9/2010) Initial Release. Broke out the jQuery BBQ event.special
//         window.onhashchange functionality into a separate plugin for users
//         who want just the basic event & back button support, without all the
//         extra awesomeness that BBQ provides. This plugin will be included as
//         part of jQuery BBQ, but also be available separately.

(function($,window,undefined){
  '$:nomunge'; // Used by YUI compressor.
  
  // Reused string.
  var str_hashchange = 'hashchange',
    
    // Method / object references.
    doc = document,
    fake_onhashchange,
    special = $.event.special,
    
    // Does the browser support window.onhashchange? Note that IE8 running in
    // IE7 compatibility mode reports true for 'onhashchange' in window, even
    // though the event isn't supported, so also test document.documentMode.
    doc_mode = doc.documentMode,
    supports_onhashchange = 'on' + str_hashchange in window && ( doc_mode === undefined || doc_mode > 7 );
  
  // Get location.hash (or what you'd expect location.hash to be) sans any
  // leading #. Thanks for making this necessary, Firefox!
  function get_fragment( url ) {
    url = url || location.href;
    return '#' + url.replace( /^[^#]*#?(.*)$/, '$1' );
  };
  
  // Method: jQuery.fn.hashchange
  // 
  // Bind a handler to the window.onhashchange event or trigger all bound
  // window.onhashchange event handlers. This behavior is consistent with
  // jQuery's built-in event handlers.
  // 
  // Usage:
  // 
  // > jQuery(window).hashchange( [ handler ] );
  // 
  // Arguments:
  // 
  //  handler - (Function) Optional handler to be bound to the hashchange
  //    event. This is a "shortcut" for the more verbose form:
  //    jQuery(window).bind( 'hashchange', handler ). If handler is omitted,
  //    all bound window.onhashchange event handlers will be triggered. This
  //    is a shortcut for the more verbose
  //    jQuery(window).trigger( 'hashchange' ). These forms are described in
  //    the <hashchange event> section.
  // 
  // Returns:
  // 
  //  (jQuery) The initial jQuery collection of elements.
  
  // Allow the "shortcut" format $(elem).hashchange( fn ) for binding and
  // $(elem).hashchange() for triggering, like jQuery does for built-in events.
  $.fn[ str_hashchange ] = function( fn ) {
    return fn ? this.bind( str_hashchange, fn ) : this.trigger( str_hashchange );
  };
  
  // Property: jQuery.fn.hashchange.delay
  // 
  // The numeric interval (in milliseconds) at which the <hashchange event>
  // polling loop executes. Defaults to 50.
  
  // Property: jQuery.fn.hashchange.domain
  // 
  // If you're setting document.domain in your JavaScript, and you want hash
  // history to work in IE6/7, not only must this property be set, but you must
  // also set document.domain BEFORE jQuery is loaded into the page. This
  // property is only applicable if you are supporting IE6/7 (or IE8 operating
  // in "IE7 compatibility" mode).
  // 
  // In addition, the <jQuery.fn.hashchange.src> property must be set to the
  // path of the included "document-domain.html" file, which can be renamed or
  // modified if necessary (note that the document.domain specified must be the
  // same in both your main JavaScript as well as in this file).
  // 
  // Usage:
  // 
  // jQuery.fn.hashchange.domain = document.domain;
  
  // Property: jQuery.fn.hashchange.src
  // 
  // If, for some reason, you need to specify an Iframe src file (for example,
  // when setting document.domain as in <jQuery.fn.hashchange.domain>), you can
  // do so using this property. Note that when using this property, history
  // won't be recorded in IE6/7 until the Iframe src file loads. This property
  // is only applicable if you are supporting IE6/7 (or IE8 operating in "IE7
  // compatibility" mode).
  // 
  // Usage:
  // 
  // jQuery.fn.hashchange.src = 'path/to/file.html';
  
  $.fn[ str_hashchange ].delay = 50;
  /*
  $.fn[ str_hashchange ].domain = null;
  $.fn[ str_hashchange ].src = null;
  */
  
  // Event: hashchange event
  // 
  // Fired when location.hash changes. In browsers that support it, the native
  // HTML5 window.onhashchange event is used, otherwise a polling loop is
  // initialized, running every <jQuery.fn.hashchange.delay> milliseconds to
  // see if the hash has changed. In IE6/7 (and IE8 operating in "IE7
  // compatibility" mode), a hidden Iframe is created to allow the back button
  // and hash-based history to work.
  // 
  // Usage as described in <jQuery.fn.hashchange>:
  // 
  // > // Bind an event handler.
  // > jQuery(window).hashchange( function(e) {
  // >   var hash = location.hash;
  // >   ...
  // > });
  // > 
  // > // Manually trigger the event handler.
  // > jQuery(window).hashchange();
  // 
  // A more verbose usage that allows for event namespacing:
  // 
  // > // Bind an event handler.
  // > jQuery(window).bind( 'hashchange', function(e) {
  // >   var hash = location.hash;
  // >   ...
  // > });
  // > 
  // > // Manually trigger the event handler.
  // > jQuery(window).trigger( 'hashchange' );
  // 
  // Additional Notes:
  // 
  // * The polling loop and Iframe are not created until at least one handler
  //   is actually bound to the 'hashchange' event.
  // * If you need the bound handler(s) to execute immediately, in cases where
  //   a location.hash exists on page load, via bookmark or page refresh for
  //   example, use jQuery(window).hashchange() or the more verbose 
  //   jQuery(window).trigger( 'hashchange' ).
  // * The event can be bound before DOM ready, but since it won't be usable
  //   before then in IE6/7 (due to the necessary Iframe), recommended usage is
  //   to bind it inside a DOM ready handler.
  
  // Override existing $.event.special.hashchange methods (allowing this plugin
  // to be defined after jQuery BBQ in BBQ's source code).
  special[ str_hashchange ] = $.extend( special[ str_hashchange ], {
    
    // Called only when the first 'hashchange' event is bound to window.
    setup: function() {
      // If window.onhashchange is supported natively, there's nothing to do..
      if ( supports_onhashchange ) { return false; }
      
      // Otherwise, we need to create our own. And we don't want to call this
      // until the user binds to the event, just in case they never do, since it
      // will create a polling loop and possibly even a hidden Iframe.
      $( fake_onhashchange.start );
    },
    
    // Called only when the last 'hashchange' event is unbound from window.
    teardown: function() {
      // If window.onhashchange is supported natively, there's nothing to do..
      if ( supports_onhashchange ) { return false; }
      
      // Otherwise, we need to stop ours (if possible).
      $( fake_onhashchange.stop );
    }
    
  });
  
  // fake_onhashchange does all the work of triggering the window.onhashchange
  // event for browsers that don't natively support it, including creating a
  // polling loop to watch for hash changes and in IE 6/7 creating a hidden
  // Iframe to enable back and forward.
  fake_onhashchange = (function(){
    var self = {},
      timeout_id,
      
      // Remember the initial hash so it doesn't get triggered immediately.
      last_hash = get_fragment(),
      
      fn_retval = function(val){ return val; },
      history_set = fn_retval,
      history_get = fn_retval;
    
    // Start the polling loop.
    self.start = function() {
      timeout_id || poll();
    };
    
    // Stop the polling loop.
    self.stop = function() {
      timeout_id && clearTimeout( timeout_id );
      timeout_id = undefined;
    };
    
    // This polling loop checks every $.fn.hashchange.delay milliseconds to see
    // if location.hash has changed, and triggers the 'hashchange' event on
    // window when necessary.
    function poll() {
      var hash = get_fragment(),
        history_hash = history_get( last_hash );
      
      if ( hash !== last_hash ) {
        history_set( last_hash = hash, history_hash );
        
        $(window).trigger( str_hashchange );
        
      } else if ( history_hash !== last_hash ) {
        location.href = location.href.replace( /#.*/, '' ) + history_hash;
      }
      
      timeout_id = setTimeout( poll, $.fn[ str_hashchange ].delay );
    };
    
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    // vvvvvvvvvvvvvvvvvvv REMOVE IF NOT SUPPORTING IE6/7/8 vvvvvvvvvvvvvvvvvvv
    // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    $.browser.msie && !supports_onhashchange && (function(){
      // Not only do IE6/7 need the "magical" Iframe treatment, but so does IE8
      // when running in "IE7 compatibility" mode.
      
      var iframe,
        iframe_src;
      
      // When the event is bound and polling starts in IE 6/7, create a hidden
      // Iframe for history handling.
      self.start = function(){
        if ( !iframe ) {
          iframe_src = $.fn[ str_hashchange ].src;
          iframe_src = iframe_src && iframe_src + get_fragment();
          
          // Create hidden Iframe. Attempt to make Iframe as hidden as possible
          // by using techniques from http://www.paciellogroup.com/blog/?p=604.
          iframe = $('<iframe tabindex="-1" title="empty"/>').hide()
            
            // When Iframe has completely loaded, initialize the history and
            // start polling.
            .one( 'load', function(){
              iframe_src || history_set( get_fragment() );
              poll();
            })
            
            // Load Iframe src if specified, otherwise nothing.
            .attr( 'src', iframe_src || 'javascript:0' )
            
            // Append Iframe after the end of the body to prevent unnecessary
            // initial page scrolling (yes, this works).
            .insertAfter( 'body' )[0].contentWindow;
          
          // Whenever `document.title` changes, update the Iframe's title to
          // prettify the back/next history menu entries. Since IE sometimes
          // errors with "Unspecified error" the very first time this is set
          // (yes, very useful) wrap this with a try/catch block.
          doc.onpropertychange = function(){
            try {
              if ( event.propertyName === 'title' ) {
                iframe.document.title = doc.title;
              }
            } catch(e) {}
          };
          
        }
      };
      
      // Override the "stop" method since an IE6/7 Iframe was created. Even
      // if there are no longer any bound event handlers, the polling loop
      // is still necessary for back/next to work at all!
      self.stop = fn_retval;
      
      // Get history by looking at the hidden Iframe's location.hash.
      history_get = function() {
        return get_fragment( iframe.location.href );
      };
      
      // Set a new history item by opening and then closing the Iframe
      // document, *then* setting its location.hash. If document.domain has
      // been set, update that as well.
      history_set = function( hash, history_hash ) {
        var iframe_doc = iframe.document,
          domain = $.fn[ str_hashchange ].domain;
        
        if ( hash !== history_hash ) {
          // Update Iframe with any initial `document.title` that might be set.
          iframe_doc.title = doc.title;
          
          // Opening the Iframe's document after it has been closed is what
          // actually adds a history entry.
          iframe_doc.open();
          
          // Set document.domain for the Iframe document as well, if necessary.
          domain && iframe_doc.write( '<script>document.domain="' + domain + '"</script>' );
          
          iframe_doc.close();
          
          // Update the Iframe's hash, for great justice.
          iframe.location.hash = hash;
        }
      };
      
    })();
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    // ^^^^^^^^^^^^^^^^^^^ REMOVE IF NOT SUPPORTING IE6/7/8 ^^^^^^^^^^^^^^^^^^^
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    
    return self;
  })();
  
})(jQuery,this);
var __slice = [].slice;

String.prototype.toCapitalCase = function() {
  return this.charAt(0).toUpperCase() + this.substr(1);
};

String.prototype.toCamelCase = function() {
  return (this.toWords().map(function(p) {
    return p.toCapitalCase();
  })).join('');
};

String.prototype.toLowerCamelCase = function() {
  var first, rest, _ref;
  _ref = this.toWords(), first = _ref[0], rest = 2 <= _ref.length ? __slice.call(_ref, 1) : [];
  return first + (rest.map(function(p) {
    return p.toCapitalCase();
  })).join('');
};

String.prototype.toWords = function() {
  return this.split(/[-_,\.]+/);
};

String.prototype.toDashCase = function() {
  return this.replace(/([A-Z])/g, function(v) {
    return '-' + v.toLowerCase();
  }).replace(/^-/, '');
};

(function() {
  var dom;
  dom = {};
  /*
    # See if current DOM support classList (HTML5)
  */

  dom.supportClassList = typeof document.documentElement.classList !== "undefined";
  dom.query = function(q, c) {
    c = c || document;
    return c.querySelector(q);
  };
  dom.queryAll = function(q, c) {
    c = c || document;
    if (!c.querySelectorAll) {
      throw new Error("Object " + typeof c + " does not contains querySelectorAll method"); 
    }
    return c.querySelectorAll(q);
  };
  dom.get = function(dom, c) {
    c = c || document;
    return c.getElementById(dom);
  };
  dom.collectionToArray = function(c) {
    var i, len, list;
    i = 0;
    len = c.length;
    list = [];
    while (i < len) {
      list.push(c[i]);
      i++;
    }
    return list;
  };
  dom.byTagName = function(n, c) {
    c = c || document;
    return c.getElementsByTagName(n);
  };
  dom.byClassName = function(n, c) {
    c = c || document;
    return c.getElementsByClassName(n);
  };
  dom.bind = function(el, n, cb) {
    return el.addEventListener(n, cb);
  };
  return window.dom = dom;
})();

(function() {
  var USet, ensureClassArray, u;
  u = function(a) {
    if (typeof a === "object" && a instanceof USet)  
      return a;
    return new USet(a);
  };
  u.dom = window.dom;
  u.ready = function(cb) {
    if (document.readyState === "complete") {
      return setTimeout(cb, 0); 
    } else {
      return document.addEventListener("DOMContentLoaded", cb, false);
    }
  };
  u.load = function(cb) {
    if (document.readyState === "complete") {
      return setTimeout(cb, 0); 
    } else {
      return window.addEventListener("load", cb, false);
    }
  };
  ensureClassArray = function(c) {
    if (typeof c === "string")  
      return c.split(" ");
    if (typeof c === "function")  
      return c();
    return c;
  };
  USet = (function() {

    function USet(a) {
      if (typeof a === "string") {
        this.els = u.dom.queryAll(a); 
      } else if (typeof a === "object" && a instanceof Array) {
        this.els = a;
        this.length = a.length; 
      } else if (a instanceof NodeList) {
        this.els = a;
        this.length = a.length; 
      } else if (typeof a === "object" || a instanceof Node) {
        this.el = a; 
      } else {
        if (window.console)  
          console.error(a);
        throw new Error("u: unsupported argument");
      }
    }

    USet.prototype.size = function() {
      if (this.els)  
        return this.els.length;
      if (this.el)  
        return 1;
      return 0;
    };

    USet.prototype.get = function(i) {
      if (this.els)  
        return this.els[i];
      if (i === 0)  
        return this.el;
    };

    USet.prototype.all = function() {
      if (this.els)  
        return this.els;
      if (this.el)  
        return [this.el];
      return [];
    };

    USet.prototype.children = function(i) {
      if (i)  
        return u(this.get(i));
      if (this.els)  
        return u(this.els);
    };

    USet.prototype.first = function() {
      return this.children(0);
    };

    USet.prototype.last = function() {
      if (this.els)  
        return this.children(this.els.length > 0 ? this.els.length - 1 : 0);
    };

    /*
        addClass, toggleClass, removeClass is little different from jQuery
        which takes a string for single class or an array for multiple
        class names.
        
        As you are already using u(), you should use
        
            u('element').addClass('class1 class2'.split(' '))
        
        Or
        
            u('element').addClass('class1')
        
        Instead of
        
            u('element').addClass('class1 class2')
        
        Because the classList is faster 8 times than jQuery.addClass
        
        Performance:
        http://jsperf.com/jquery-addclass-vs-dom-classlist/4
        
        Support:
        https://developer.mozilla.org/en-US/docs/DOM/element.classList
    */


    USet.prototype.addClass = function(cls) {
      var c, el, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      if (typeof cls === "object") {
        for (_i = 0, _len = cls.length; _i < _len; _i++) {
          c = cls[_i];
          _ref = this.all();
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            el = _ref[_j];
            el.classList.add(c);
          }
        } 
      } else {
        _ref1 = this.all();
        for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
          el = _ref1[_k];
          el.classList.add(cls);
        }
      }
      return this;
    };

    USet.prototype.toggleClass = function(cls) {
      var c, el, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      if (typeof cls === "object") {
        for (_i = 0, _len = cls.length; _i < _len; _i++) {
          c = cls[_i];
          _ref = this.all();
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            el = _ref[_j];
            el.classList.toggle(c);
          }
        } 
      } else {
        _ref1 = this.all();
        for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
          el = _ref1[_k];
          el.classList.toggle(cls);
        }
      }
      return this;
    };

    USet.prototype.removeClass = function(cls) {
      var c, el, _i, _j, _k, _len, _len1, _len2, _ref, _ref1;
      if (typeof cls === "object") {
        for (_i = 0, _len = cls.length; _i < _len; _i++) {
          c = cls[_i];
          _ref = this.all();
          for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
            el = _ref[_j];
            el.classList.remove(c);
          }
        } 
      } else {
        _ref1 = this.all();
        for (_k = 0, _len2 = _ref1.length; _k < _len2; _k++) {
          el = _ref1[_k];
          el.classList.remove(cls);
        }
      }
      return this;
    };

    USet.prototype.hasClass = function(cls) {
      var el, _i, _len, _ref;
      _ref = this.all();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        el = _ref[_i];
        if (!el.classList.contains(cls))  
          return false;
      }
      return true;
    };

    USet.prototype.css = function(n, v) {
      if (n && v) {
        return this.each(function(i, el) {
          return el.style[n] = v;
        }); 
      } else if (typeof n === "object")  
        return this.each(function(i, el) {
          var k, val, _results;
          _results = [];
          for (k in n) {
            val = n[k];
            _results.push(el.style[k] = val);
          }
          return _results;
        });
      if (typeof n === "string" && this.el)  
        return this.el.style[n];
    };

    USet.prototype.attr = function(n, v) {
      var _ref;
      if (n && v) {
        return this.each(function(i, el) {
          return el.setAttribute(n, v);
        }); 
      } else if (typeof n === "object")  
        return this.each(function(i, el) {
          var k, val, _i, _len, _results;
          _results = [];
          for (val = _i = 0, _len = n.length; _i < _len; val = ++_i) {
            k = n[val];
            _results.push(el.setAttribute(k, val));
          }
          return _results;
        });
      if (typeof n === "string")  
        return (_ref = this.get(0)) != null ? _ref.getAttribute(n) : void 0;
    };

    USet.prototype.empty = function() {
      return this.each(function(i, el) {
        return el.innerHTML = '';
      });
    };

    USet.prototype.each = function(cb) {
      var b, els, i, len;
      els = this.all();
      if (!els)  
        return;
      i = 0;
      len = els.length;
      while (i < len) {
        b = cb.call(els[i], i, els[i]);
        if (b === false) {
          break; 
        }
        i++;
      }
      return this;
    };

    /*
        Trigger a native element
        
        @param string n event name
    */


    USet.prototype.trigger = function(n) {
      var evt;
      evt = document.createEvent("HTMLEvents");
      evt.initEvent(n, true, true);
      return this.each(function(i, el) {
        return el.dispatchEvent(evt);
      });
    };

    USet.prototype.click = function(cb) {
      return this.bind("click", cb);
    };

    USet.prototype.on = function(n, cb) {
      return this.bind(n, cb);
    };

    USet.prototype.bind = function(n, cb) {
      return this.each(function(i, el, capture) {
        return el.addEventListener(n, cb, capture);
      });
    };

    USet.prototype.parent = function() {
      var e;
      e = this.get(0);
      if (e)  
        return u(e.parentNode);
    };

    USet.prototype.find = function(sel) {
      var el, els, n, nodes, _i, _j, _len, _len1, _ref;
      els = [];
      _ref = this.all();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        el = _ref[_i];
        nodes = u.dom.queryAll(sel, el);
        for (_j = 0, _len1 = nodes.length; _j < _len1; _j++) {
          n = nodes[_j];
          els.push(n);
        }
      }
      return u(els);
    };

    USet.prototype.findone = function(sel) {
      var el, node, _i, _len, _ref;
      _ref = this.all();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        el = _ref[_i];
        node = u.dom.query(sel, el);
        if (node)  
          return u(node);
      }
    };

    USet.prototype.siblings = function(sel) {
      if (sel)  
        return this.parent().find(sel);
      return this.parent().children();
    };

    USet.prototype.filter = function(cb) {
      var e, els, newlist, _i, _len;
      newlist = [];
      els = this.all();
      for (_i = 0, _len = els.length; _i < _len; _i++) {
        e = els[_i];
        if (cb.call(e, e))  
          newlist.push(e);
      }
      return u(newlist);
    };

    USet.prototype.next = function() {
      var e;
      e = this.get(0);
      if (e)  
        return u(e.nextSibling);
    };

    USet.prototype.prev = function() {
      var e;
      e = this.get(0);
      if (e)  
        return u(e.prevSibling);
    };

    /*
        Returns style or computed style
    */


    USet.prototype.style = function(computed, update) {
      var el;
      if (update == null)  
        update = false;
      el = this.get(0);
      if (!el)  
        return;
      if (computed) {
        if (this.cstyle && !update)  
          return this.cstyle;
        return this.cstyle = window.getComputedStyle(el); 
      }
      return el.style;
    };

    USet.prototype.data = function(n, v) {
      var datakey, el;
      el = this.get(0);
      if (el) {
        if (n && v) {
          if (typeof v === "string" || typeof v === "boolean") {
            return this.attr('data-' + n, v); 
          } else {
            console.error('not implemented yet.');
          } 
        } else if (n) {
          datakey = n.toLowerCamelCase();
          if (typeof el.dataset !== 'undefined') {
            return el.dataset[datakey]; 
          } else {
            return this.attr(n);
          } 
        } 
      }
      return this;
    };

    USet.prototype.height = function(a) {
      var el;
      if (a) {
        return this.each(function(i, e) {
          return e.style.height = parseInt(a) + 'px';
        }); 
      } else {
        el = this.get(0);
        if (el != null ? el.style.height : void 0)  
          return parseInt(el.style.height);
        return parseInt(this.style(1).height);
      }
    };

    USet.prototype.width = function(a) {
      var el;
      if (a) {
        return this.each(function(i, e) {
          return e.style.width = parseInt(a) + 'px';
        }); 
      } else {
        el = this.get(0);
        if (el != null ? el.style.width : void 0)  
          return parseInt(el.style.width);
        return parseInt(style(1).width);
      }
    };

    USet.prototype.toArray = function() {
      return this.all();
    };

    USet.prototype.jQuery = function() {
      return $(this.els || this.el);
    };

    return USet;

  })();
  return window.u = u;
})();

(function() {
  u._widgets = {};
  /*
    Widget base class
  */

  u.Widget = (function() {

    function Widget() {}

    return Widget;

  })();
  /*
    Widget factory method
  
        @param string name
        @param closure factory
  */

  return u.widget = function(name, factory) {
    if (factory)  
      return u[name] = function(options) {
        return factory.apply(options);
      };
  };
})();

(function() {
  window.umobi = {};
})();

(function() {
  umobi.config = {
    cssTouchScroll: false,
    webkitOverflowScrolling: 'touch',
    enablePage: true,
    theme: 'c'
  };
})();
var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

(function() {
  var support;
  support = {
    offlineCache: typeof window.applicationCache !== 'undefined',
    classList: typeof document.documentElement !== 'undefined',
    touch: navigator.userAgent.match(/(iPhone|iPad|Android|Mobile)/)
  };
  support.matrix = "WebKitCSSMatrix" in window;
  support.matrixM11 = support.matrix && (__indexOf.call(new WebKitCSSMatrix(), "m11") >= 0);
  umobi.support = support;
})();

(function() {
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
  return umobi.scroller.create = function(element) {
    return new Scroller(element);
  };
})();

(function() {
  var TapDetector;
  TapDetector = (function() {

    TapDetector.prototype.moved = false;

    function TapDetector(element) {
      this.element = element;
      this.element.addEventListener("touchstart", this, false);
    }

    TapDetector.prototype.handleEvent = function(e) {
      switch (e.type) {
        case "touchmove":
          return this.onTouchMove(e);
        case "touchstart":
          return this.onTouchStart(e);
        case "touchend":
          return this.onTouchEnd(e);
      }
    };

    TapDetector.prototype.onTouchStart = function(e) {
      var _this = this;
      this.moved = false;
      this.theTarget = document.elementFromPoint(e.targetTouches[0].clientX, e.targetTouches[0].clientY);
      this._t = setTimeout((function() {}), 200);
      this.element.addEventListener("touchmove", this, false);
      return this.element.addEventListener("touchend", this, false);
    };

    TapDetector.prototype.onTouchMove = function(e) {
      this.moved = true;
      return clearTimeout(this._t);
    };

    TapDetector.prototype.onTouchEnd = function(e) {
      this.element.removeEventListener("touchmove", this, false);
      this.element.removeEventListener("touchend", this, false);
      if (!this.moved && this.theTarget)  
        return $(this.theTarget).trigger("tap");
    };

    return TapDetector;

  })();
  return u.ready(function() {
    return $("a,button").each(function(i, e) {
      return new TapDetector(this);
    });
  });
})();

(function() {
  umobi.button = {};
  umobi.button.all = function() {
    return u.dom.queryAll('[data-role="button"]');
  };
  umobi.button.markup = function(el) {
    var $el;
    $el = $(el);
    return $el.wrapInner("<span class=\"ui-btn ui-btn-corner-all\">\n  <span class=\"ui-btn-text\">\n  </span>\n</span>");
  };
  umobi.button.bindClassEvents = function(el) {
    var $el, cmap, theme;
    $el = $(el);
    theme = umobi.config.theme;
    cmap = {
      up: "ui-btn-up-" + theme,
      down: "ui-btn-down-" + theme,
      hover: "ui-btn-hover-" + theme,
      active: "ui-btn-active-" + theme
    };
    $el.addClass(cmap.up);
    $el.hover((function() {
      return u(this).removeClass([cmap.up, cmap.down]).addClass(cmap.hover);
    }), (function() {
      return u(this).removeClass([cmap.down, cmap.hover]).addClass(cmap.up);
    }));
    $el.on("tap", function(e) {
      return u(this).removeClass([cmap.hover, cmap.up]).addClass(cmap.down);
    });
    $el.on("mousedown", function(e) {
      return u(this).removeClass([cmap.hover, cmap.up]).addClass(cmap.down);
    });
    $el.on('mouseup', function(e) {
      return u(this).removeClass(cmap.down).addClass(cmap.hover);
    });
    return $el.on('click', function(e) {
      return u(this).removeClass([cmap.hover, cmap.down]).addClass(cmap.active);
    });
  };
  return u.ready(function() {
    var $icon, $link, b, btn, buttons, el, iconpos, icontype, link, linkbuttons, _i, _j, _len, _len1, _ref, _ref1, _results;
    linkbuttons = u('a[data-role="button"]');
    _ref = linkbuttons.all();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      el = _ref[_i];
      link = u(el);
      link.data("corners", true).data("shadow", true).data("theme", umobi.config.theme);
      link.addClass(["ui-btn", "ui-shadow", "ui-btn-corner-all"]);
      if (link.data("mini"))  
        link.addClass("ui-mini");
      if (link.data("inline"))  
        link.addClass("ui-inline");
      $link = $(el);
      $link.wrapInner("<span class=\"ui-btn-text\">\n</span>");
      $link.wrapInner("<span class=\"ui-btn-inner\">\n</span>");
      if (icontype = $link.data("icon")) {
        iconpos = $link.data("iconpos");
        if (iconpos == null)  
          iconpos = "left";
        $icon = $('<span/>');
        $icon.addClass("ui-icon icon-" + icontype);
        $icon.addClass("ui-icon-" + iconpos);
        $link.addClass("ui-btn-icon-" + iconpos);
        $link.children(0).prepend($icon); 
      }
      umobi.button.bindClassEvents($link);
    }
    buttons = u('button, input[type="button"]');
    _ref1 = buttons.all();
    _results = [];
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      btn = _ref1[_j];
      b = u(btn);
      b.addClass(["ui-btn", "ui-btn-corner-all", "ui-shadow"]);
      if (b.data("mini"))  
        b.addClass("ui-mini");
      if (b.data("inline"))  
        b.addClass("ui-inline");
      $(btn).wrapInner("<span class=\"ui-btn-text\">\n</span>");
      $(btn).wrapInner("<span class=\"ui-btn-inner\">\n</span>");
      if (icontype = b.data("icon")) {
        iconpos = b.data("iconpos");
        if (iconpos == null)  
          iconpos = "left";
        $icon = $('<span/>');
        $icon.addClass("ui-icon icon-" + icontype);
        $icon.addClass("ui-icon-" + iconpos);
        b.addClass("ui-btn-icon-" + iconpos);
        $(btn).children(0).prepend($icon); 
      }
      _results.push(umobi.button.bindClassEvents($(btn)));
    }
    return _results;
  });
})();
/*
To inner wrap a link with ui-btn classes:

<a href="index.html" data-role="button" data-corners="true"
  data-shadow="true" data-iconshadow="true" data-wrapperels="span"
  data-theme="c" class="ui-btn ui-shadow ui-btn-corner-all ui-btn-up-c">
    <span class="ui-btn-inner ui-btn-corner-all">
      <span class="ui-btn-text">Link button</span>
    </span>
</a>
*/

u.ready(function() {
  var link, ulink, _i, _len, _ref, _results;
  _ref = document.links;
  _results = [];
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    link = _ref[_i];
    ulink = u(link);
    if (!ulink.data('role'))  
      ulink.addClass('ui-link');
    _results.push(ulink.click(function(e) {
      var hash, href, regs;
      href = ulink.attr("href");
      if (/^#\w+/)  
        umobi.page.revealByHash(href);
      regs = href.match(/(#\w+)/);
      hash = regs ? regs[1] : "#index";
      if (ulink.data("ajax")) {
        e.preventDefault();
        $.ajax({
          url: href,
          dataType: "html",
          success: function(html) {
            var $body, $page, body;
            body = document.createElement("body");
            body.innerHTML = html;
            $body = $(body);
            $page = $body.find(hash);
            if (!$page.get(0))  
              $page = $body.find('[data-role="page"]').first();
            return $(document.body).append($page);
          },
          error: function(err) {
            return console.error("error", err);
          }
        });
        return false; 
      }
    }));
  }
  return _results;
});

u.ready(function() {
  var $a, $inner, $li, li, lis, listview, listviews, ulistview, _i, _len, _results;
  listviews = u.dom.queryAll('ul[data-role="listview"]');
  _results = [];
  for (_i = 0, _len = listviews.length; _i < _len; _i++) {
    listview = listviews[_i];
    ulistview = u(listview);
    listview.classList.add('ui-listview');
    if (ulistview.attr('data-inset'))  
      listview.classList.add('ui-listview-inset');
    lis = dom.queryAll('li', listview);
    _results.push((function() {
      var _j, _len1, _results1;
      _results1 = [];
      for (_j = 0, _len1 = lis.length; _j < _len1; _j++) {
        li = lis[_j];
        li.classList.add('ui-li');
        li.classList.add('ui-btn');
        $li = $(li);
        $a = $li.find('a');
        $inner = $('<div/>').addClass('ui-btn-inner').append($a);
        _results1.push($li.empty().append($inner));
      }
      return _results1;
    })());
  }
  return _results;
});

(function() {
  umobi.handleHashChange = function(e) {
    return umobi.page.revealByHash(location.hash);
  };
  $(window).on('hashchange', function(e) {
    return umobi.handleHashChange(e);
  });
  return window.umobi.Navigator = (function() {

    function Navigator() {}

    Navigator.prototype.urlParseRE = /^\s*(((([^:\/#\?]+:)?(?:(\/\/)((?:(([^:@\/#\?]+)(?:\:([^:@\/#\?]+))?)@)?(([^:\/#\?\]\[]+|\[[^\/\]@#?]+\])(?:\:([0-9]+))?))?)?)?((\/?(?:[^\/\?#]+\/+)*)([^\?#]*)))?(\?[^#]+)?)(#.*)?/;

    Navigator.prototype.getLocation = function(url) {
      var hash, uri;
      uri = url ? this.parseUrl(url) : location;
      hash = this.parseUrl(url || location.href).hash;
      hash = hash === "#" ? "" : hash;
      return uri.protocol + "//" + uri.host + uri.pathname + uri.search + hash;
    };

    Navigator.prototype.parseLocation = function() {
      return this.parseUrl(this.getLocation());
    };

    Navigator.prototype.parseUrl = function(url) {
      var data, matches;
      if ($.type(url) === "object")  
        return url;
      matches = path.urlParseRE.exec(url || "") || [];
      data = {
        href: matches[0] || "",
        hrefNoHash: matches[1] || "",
        hrefNoSearch: matches[2] || "",
        domain: matches[3] || "",
        protocol: matches[4] || "",
        doubleSlash: matches[5] || "",
        authority: matches[6] || "",
        username: matches[8] || "",
        password: matches[9] || "",
        host: matches[10] || "",
        hostname: matches[11] || "",
        port: matches[12] || "",
        pathname: matches[13] || "",
        directory: matches[14] || "",
        filename: matches[15] || "",
        search: matches[16] || "",
        hash: matches[17] || ""
      };
      return data;
    };

    Navigator.prototype.makePathAbsolute = function(relPath, absPath) {
      var absStack, d, relStack, _i, _len;
      if (relPath && relPath.charAt(0) === "/")  
        return relPath;
      relPath = relPath || "";
      absPath = absPath ? absPath.replace(/^\/|(\/[^\/]*|[^\/]+)$/g, "") : "";
      absStack = absPath ? absPath.split("/") : [];
      relStack = relPath.split("/");
      for (_i = 0, _len = relStack.length; _i < _len; _i++) {
        d = relStack[_i];
        switch (d) {
          case ".":
            1;
            break;
          case "..":
            if (absStack.length)  
              absStack.pop();
            break;
          default:
            absStack.push(d);
        }
      }
      return "/" + absStack.join("/");
    };

    return Navigator;

  })();
})();

(function() {
  var c;
  c = window.applicationCache;
  switch (c.status) {
    case c.UNCACHED:
      return 'UNCACHED';
    case c.IDLE:
      return 'IDLE';
    case c.CHECKING:
      return 'CHECKING';
    case c.DOWNLOADING:
      return 'DOWNLOADING';
    case c.UPDATEREADY:
      return 'UPDATEREADY';
    case c.OBSOLETE:
      return 'OBSOLETE';
    default:
      return 'UKNOWN CACHE STATUS';
  }
})();

(function() {
  umobi.splitview = {
    init: function() {
      var view, _i, _len, _ref, _results;
      _ref = u('[data-role="splitview"]').all();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        view = _ref[_i];
        _results.push(umobi.splitview.create(view));
      }
      return _results;
    },
    create: function(view) {
      var contentPrimary, contentSecondary;
      contentPrimary = u(view).findone('[data-role="content-primary"]');
      contentSecondary = u(view).findone('[data-role="content-secondary"]');
      contentSecondary.addClass("ui-content-secondary");
      return contentPrimary.addClass("ui-content-primary");
    }
  };
  return u.ready(function() {
    return umobi.splitview.init();
  });
})();

(function() {
  var f, tag, tags, _i, _len, _results;
  tags = ["article", "section", "header", "footer", "aside", "details", "summary", "page"];
  f = document.createDocumentFragment();
  _results = [];
  for (_i = 0, _len = tags.length; _i < _len; _i++) {
    tag = tags[_i];
    _results.push(f.appendChild(document.createElement(tag)));
  }
  return _results;
})();

(function() {
  return u.ready(function() {
    var $input, input, inputs, textareas, uiClass, _i, _j, _len, _len1, _ref, _ref1, _results;
    inputs = u('input[type="text"],input[type="password"]');
    _ref = inputs.all();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      input = _ref[_i];
      $input = $(input);
      uiClass = "ui-input-text";
      input.className += uiClass;
      $input.wrap('<div class="' + uiClass + ' ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c"></div>');
      $input.focus(function() {
        return $(this).parent().addClass('ui-focus');
      });
      $input.blur(function() {
        return $(this).parent().removeClass('ui-focus');
      });
      if ($input.data("mini"))  
        $input.parent().addClass("ui-mini");
    }
    textareas = u('textarea');
    _ref1 = textareas.all();
    _results = [];
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      input = _ref1[_j];
      input.className += "ui-input-text ui-shadow-inset ui-corner-all ui-btn-shadow ui-body-c";
      $input.focus(function() {
        return $(this).addClass('ui-focus');
      });
      $input.blur(function() {
        return $(this).removeClass('ui-focus');
      });
      if ($input.data("mini")) {
        _results.push($input.parent().addClass("ui-mini")); 
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });
})();

(function() {
  var disabledInitially, disabledZoom, enabledZoom, initialContent, meta;
  meta = $("meta[name=viewport]");
  initialContent = meta.attr("content");
  disabledZoom = initialContent + ",maximum-scale=1, user-scalable=no";
  enabledZoom = initialContent + ",maximum-scale=10, user-scalable=yes";
  disabledInitially = /(user-scalable[\s]*=[\s]*no)|(maximum-scale[\s]*=[\s]*1)[$,\s]/.test(initialContent);
  return umobi.zoom = $.extend({}, {
    enabled: !disabledInitially,
    locked: false,
    disable: function(lock) {
      if (!disabledInitially && !umobi.zoom.locked) {
        meta.attr("content", disabledZoom);
        umobi.zoom.enabled = false;
        return umobi.zoom.locked = lock || false; 
      }
    },
    enable: function(unlock) {
      if (!disabledInitially && (!umobi.zoom.locked || unlock !== true)) {
        meta.attr("content", enabledZoom);
        umobi.zoom.enabled = true;
        return umobi.zoom.locked = false; 
      }
    },
    restore: function() {
      if (!disabledInitially) {
        meta.attr("content", initialContent);
        return umobi.zoom.enabled = true; 
      }
    }
  });
})();
/*
uMobi page UI navigation feature
*/

(function() {
  u('body').css('overflow', 'hidden').addClass('ui-overlay-c');
  return umobi.page = {
    findAll: function() {
      return u('[data-role="page"],page');
    },
    findActive: function() {
      return u('.ui-page-active');
    },
    /*
        Initialize page components from elements and load correct page by hash or
        by index.
    */

    init: function() {
      var indexPage, pages,
        _this = this;
      $(document).trigger('pageinit');
      pages = this.findAll();
      if (!pages.get(0))  
        pages = u($("body").wrapInner("<div data-role=\"page\"></div>").children(0).get(0));
      pages.each(function(i, e) {
        return _this.create(e);
      });
      if (location.hash) {
        return this.revealByHash(location.hash); 
      } else {
        indexPage = u('#index');
        if (indexPage.get(0)) {
          return this.reveal(indexPage); 
        } else {
          return this.reveal(pages.first());
        }
      }
    },
    reveal: function(p) {
      this.findActive().removeClass("ui-page-active");
      p.addClass("ui-page-active").trigger("pagereveal");
      return $(document).trigger("pagereveal", [p]);
    },
    revealByHash: function(hash) {
      var upage;
      upage = u(hash);
      if (!upage.get(0))  
        upage = u('[data-role="page"]').first();
      return umobi.page.reveal(upage);
    },
    create: function(el) {
      var $c, AdjustContentHeight, AdjustContentPadding, c, f, h, isBothFixed, resizeTimeout, upage;
      upage = u(el).addClass(["ui-page", "ui-body-" + umobi.config.theme]);
      upage.trigger("pagecreate");
      h = upage.find('[data-role="header"],header').addClass("ui-header");
      f = upage.find('[data-role="footer"],footer').addClass("ui-footer");
      c = upage.find('[data-role="content"]').addClass("ui-content");
      h.find("h1,h2,h3,h4,h5,h6").addClass("ui-title");
      isBothFixed = h.data("fixed" || f.data("fixed"));
      if (isBothFixed) {
        $c = c.jQuery();
        if (umobi.support.touch && umobi.config.cssTouchScroll) {
          umobi.scroller.create(c.get(0));
          document.documentElement.style.overflow = "hidden";
          $c.addClass("ui-content-scroll");
          upage.addClass("ui-fixed-page"); 
        }
        if (umobi.config.cssTouchScroll) {
          AdjustContentHeight = function(e) {
            var contentBottom, contentHeight, contentTop;
            contentHeight = $(window).height();
            contentTop = h.get(0) ? h.height() : 0;
            contentBottom = f.get(0) ? f.height() : 0;
            return $c.css({
              position: "absolute",
              top: contentTop,
              left: 0,
              bottom: contentBottom,
              overflow: umobi.support.touch ? "hidden" : "auto"
            });
          };
          upage.on("pagereveal", AdjustContentHeight); 
        } else {
          AdjustContentPadding = function() {
            var contentBottom, contentTop;
            contentTop = h.get(0) ? h.height() : 0;
            contentBottom = f.get(0) ? f.height() : 0;
            return $c.css({
              marginTop: contentTop,
              marginBottom: contentBottom
            });
          };
          upage.on("pagereveal", AdjustContentPadding);
        } 
      }
      resizeTimeout = null;
      u(window).on("resize", function() {
        if (resizeTimeout)  
          clearTimeout(resizeTimeout);
        return resizeTimeout = setTimeout(AdjustContentHeight, 100);
      });
      if (h.attr("data-fixed"))  
        h.addClass("ui-fixed-header");
      if (f.attr("data-fixed"))  
        return f.addClass("ui-fixed-footer");
    }
  };
})();

(function() {
  var uhtml;
  uhtml = u('html');
  uhtml.children(0).addClass(['ui-mobile', 'ui-mobile-rendering']);
  return u.ready(function() {
    var d, hideAddressBar;
    if (umobi.config.enablePage) {
      umobi.page.init();
      if (window.navigator.userAgent.match(/iPhone|iPad|Android/)) {
        d = document;
        hideAddressBar = function() {
          if (d.documentElement.scrollHeight < (window.outerHeight / window.devicePixelRatio))  
            d.documentElement.style.height = (window.outerHeight / window.devicePixelRatio) + 'px';
          return window.scrollTo(0, 1);
        };
        window.addEventListener("load", hideAddressBar);
        window.addEventListener("orientationchange", hideAddressBar);
        $(d).on('pagereveal', hideAddressBar); 
      } 
    }
    u.load(function() {
      return uhtml.removeClass('ui-mobile-rendering');
    });
    return u(document.body).addClass("ui-body-c");
  });
})();
