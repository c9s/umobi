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
(function ( root, doc, factory ) {
	if ( typeof define === "function" && define.amd ) {
		// AMD. Register as an anonymous module.
		define( [ "jquery" ], function ( $ ) {
			factory( $, root, doc );
			return window.umobi;
		});
	} else {
		// Browser globals
		factory( root.jQuery, root, doc );
	}
}( this, document, function ( jQuery, window, document, undefined ) {

if(typeof define === "undefined" ) {
    // creates the define method on window, only used where async loading
    // is not desired in the docs and experiments
    window.define = function() {
        Array.prototype.slice.call( arguments ).pop()( window.jQuery );
    };
}
;
/**
 * classList.js: Cross-browser full element.classList implementation.
 * 2011-06-15
 *
 * By Eli Grey, http://eligrey.com
 * Public Domain.
 * NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.
 */
 
/*global self, document, DOMException */
 
/*! @source http://purl.eligrey.com/github/classList.js/blob/master/classList.js*/
 
if (typeof document !== "undefined" && !("classList" in document.documentElement)) {
 
(function (view) {
 

 
var classListProp = "classList"
    , protoProp = "prototype"
    , elemCtrProto = (view.HTMLElement || view.Element)[protoProp]
    , objCtr = Object
    , strTrim = String[protoProp].trim || function () {
        return this.replace(/^\s+|\s+$/g, "");
    }
    , arrIndexOf = Array[protoProp].indexOf || function (item) {
        var i = 0 , len = this.length;
        for (; i < len; i++) {
            if (i in this && this[i] === item) {
                return i;
            }
        }
        return -1;
    }
    // Vendors: please allow content code to instantiate DOMExceptions
    , DOMEx = function (type, message) {
        this.name = type;
        this.code = DOMException[type];
        this.message = message;
    }
    , checkTokenAndGetIndex = function (classList, token) {
        if (token === "") {
            throw new DOMEx(
                  "SYNTAX_ERR"
                , "An invalid or illegal string was specified"
            );
        }
        if (/\s/.test(token)) {
            throw new DOMEx(
                  "INVALID_CHARACTER_ERR"
                , "String contains an invalid character"
            );
        }
        return arrIndexOf.call(classList, token);
    }
    , ClassList = function (elem) {
        var
              trimmedClasses = strTrim.call(elem.className)
            , classes = trimmedClasses ? trimmedClasses.split(/\s+/) : []
            , i = 0
            , len = classes.length
        ;
        for (; i < len; i++) {
            this.push(classes[i]);
        }
        this._updateClassName = function () {
            elem.className = this.toString();
        };
    }
    , classListProto = ClassList[protoProp] = []
    , classListGetter = function () {
        return new ClassList(this);
    }
;
// Most DOMException implementations don't allow calling DOMException's toString()
// on non-DOMExceptions. Error's toString() is sufficient here.
DOMEx[protoProp] = Error[protoProp];
classListProto.item = function (i) {
    return this[i] || null;
};
classListProto.contains = function (token) {
    token += "";
    return checkTokenAndGetIndex(this, token) !== -1;
};
classListProto.add = function (token) {
    token += "";
    if (checkTokenAndGetIndex(this, token) === -1) {
        this.push(token);
        this._updateClassName();
    }
};
classListProto.remove = function (token) {
    token += "";
    var index = checkTokenAndGetIndex(this, token);
    if (index !== -1) {
        this.splice(index, 1);
        this._updateClassName();
    }
};
classListProto.toggle = function (token) {
    token += "";
    if (checkTokenAndGetIndex(this, token) === -1) {
        this.add(token);
    } else {
        this.remove(token);
    }
};
classListProto.toString = function () {
    return this.join(" ");
};
 
if (objCtr.defineProperty) {
    var classListPropDesc = {
          get: classListGetter
        , enumerable: true
        , configurable: true
    };
    try {
        objCtr.defineProperty(elemCtrProto, classListProp, classListPropDesc);
    } catch (ex) { // IE 8 doesn't support enumerable:true
        if (ex.number === -0x7FF5EC54) {
            classListPropDesc.enumerable = false;
            objCtr.defineProperty(elemCtrProto, classListProp, classListPropDesc);
        }
    }
} else if (objCtr[protoProp].__defineGetter__) {
    elemCtrProto.__defineGetter__(classListProp, classListGetter);
}
 
}(self));
 
}
;
var __slice = [].slice;

define('cs!str',[], function() {
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
  return String.prototype.toDashCase = function() {
    return this.replace(/([A-Z])/g, function(v) {
      return '-' + v.toLowerCase();
    }).replace(/^-/, '');
  };
});

/*
  */
  (function() {
    return window.umobi = {
      config: {
        touchScroll: true,
        theme: 'c'
      }
    };
  })();
  /*
    */
;
/*
  */
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
  /*
    */
;
/*
  */
  (function() {
    var USet, ensureClassArray, u;
    u = function(a) {
      if (typeof a === "object" && a instanceof USet) {
        return a;
      }
      return new USet(a);
    };
    u.dom = window.dom;
    u.ready = function(cb) {
      if (document.readyState === "complete") {
        return setTimeout(cb);
      } else {
        return document.addEventListener("DOMContentLoaded", cb, false);
      }
    };
    u.load = function(cb) {
      if (document.readyState === "complete") {
        return setTimeout(cb);
      } else {
        return window.addEventListener("load", cb, false);
      }
    };
    ensureClassArray = function(c) {
      if (typeof c === "string") {
        return c.split(" ");
      }
      if (typeof c === "function") {
        return c();
      }
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
          if (window.console) {
            console.error(a);
          }
          throw new Error("u: unsupported argument");
        }
      }

      USet.prototype.size = function() {
        if (this.els) {
          return this.els.length;
        }
        if (this.el) {
          return 1;
        }
        return 0;
      };

      USet.prototype.get = function(i) {
        if (this.els) {
          return this.els[i];
        }
        if (i === 0) {
          return this.el;
        }
      };

      USet.prototype.all = function() {
        if (this.els) {
          return this.els;
        }
        if (this.el) {
          return [this.el];
        }
        return [];
      };

      USet.prototype.children = function(i) {
        if (i) {
          return u(this.get(i));
        }
        if (this.els) {
          return u(this.els);
        }
      };

      USet.prototype.first = function() {
        return this.children(0);
      };

      USet.prototype.last = function() {
        if (this.els) {
          return this.children(this.els.length > 0 ? this.els.length - 1 : 0);
        }
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
          if (!el.classList.contains(cls)) {
            return false;
          }
        }
        return true;
      };

      USet.prototype.css = function(n, v) {
        if (n && v) {
          return this.each(function(i, el) {
            return el.style[n] = v;
          });
        } else if (typeof n === "object") {
          return this.each(function(i, el) {
            var k, val, _results;
            _results = [];
            for (k in n) {
              val = n[k];
              _results.push(el.style[k] = val);
            }
            return _results;
          });
        }
        if (typeof n === "string" && this.el) {
          return this.el.style[n];
        }
      };

      USet.prototype.attr = function(n, v) {
        var _ref;
        if (n && v) {
          return this.each(function(i, el) {
            return el.setAttribute(n, v);
          });
        } else if (typeof n === "object") {
          return this.each(function(i, el) {
            var k, val, _i, _len, _results;
            _results = [];
            for (val = _i = 0, _len = n.length; _i < _len; val = ++_i) {
              k = n[val];
              _results.push(el.setAttribute(k, val));
            }
            return _results;
          });
        }
        if (typeof n === "string") {
          return (_ref = this.get(0)) != null ? _ref.getAttribute(n) : void 0;
        }
      };

      USet.prototype.empty = function() {
        return this.each(function(i, el) {
          return el.innerHTML = '';
        });
      };

      USet.prototype.each = function(cb) {
        var b, els, i, len;
        els = this.all();
        if (!els) {
          return;
        }
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
        if (e) {
          return u(e.parentNode);
        }
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
          if (node) {
            return u(node);
          }
        }
      };

      USet.prototype.siblings = function(sel) {
        if (sel) {
          return this.parent().find(sel);
        }
        return this.parent().children();
      };

      USet.prototype.filter = function(cb) {
        var e, els, newlist, _i, _len;
        newlist = [];
        els = this.all();
        for (_i = 0, _len = els.length; _i < _len; _i++) {
          e = els[_i];
          if (cb.call(e, e)) {
            newlist.push(e);
          }
        }
        return u(newlist);
      };

      USet.prototype.next = function() {
        var e;
        e = this.get(0);
        if (e) {
          return u(e.nextSibling);
        }
      };

      USet.prototype.prev = function() {
        var e;
        e = this.get(0);
        if (e) {
          return u(e.prevSibling);
        }
      };

      /*
            Returns style or computed style
      */


      USet.prototype.style = function(computed, update) {
        var el;
        if (update == null) {
          update = false;
        }
        el = this.get(0);
        if (!el) {
          return;
        }
        if (computed) {
          if (this.cstyle && !update) {
            return this.cstyle;
          }
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
          if (el != null ? el.style.height : void 0) {
            return parseInt(el.style.height);
          }
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
          if (el != null ? el.style.width : void 0) {
            return parseInt(el.style.width);
          }
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
  /*
    */
;
/*
  */
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
      hover: "ui-btn-hover-" + theme
    };
    $el.addClass(cmap.up);
    $el.hover((function() {
      return u(this).removeClass([cmap.up, cmap.down]).addClass(cmap.hover);
    }), (function() {
      return u(this).removeClass([cmap.down, cmap.hover]).addClass(cmap.up);
    }));
    $el.on('mousedown', function() {
      return u(this).removeClass(cmap.hover).removeClass(cmap.up).addClass(cmap.down);
    });
    return $el.on('mouseup', function() {
      return u(this).removeClass(cmap.down).addClass(cmap.hover);
    });
  };
  u.ready(function() {
    var $link, button, buttons, el, link, linkbuttons, _i, _j, _len, _len1, _ref, _ref1, _results;
    linkbuttons = u('a[data-role="button"]');
    _ref = linkbuttons.all();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      el = _ref[_i];
      link = u(el);
      link.data("corners", true).data("shadow", true).data("theme", umobi.config.theme);
      link.addClass(["ui-btn", "ui-shadow", "ui-btn-corner-all"]);
      if (link.data("mini")) {
        link.addClass("ui-mini");
      }
      $link = $(el);
      $link.wrapInner("<span class=\"ui-btn ui-btn-corner-all\">\n  <span class=\"ui-btn-text\">\n  </span>\n</span>");
      umobi.button.bindClassEvents($link);
    }
    buttons = u('button, input[type="button"]');
    _ref1 = buttons.all();
    _results = [];
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      button = _ref1[_j];
      u(button).addClass(["ui-btn", "ui-btn-corner-all", "ui-shadow"]);
      if (u(button).data("mini")) {
        u(button).addClass("ui-mini");
      }
      _results.push(umobi.button.bindClassEvents($(button)));
    }
    return _results;
  });
  /*
    */
;
/*
  */
  $(function() {
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
      if ($input.data("mini")) {
        $input.parent().addClass("ui-mini");
      }
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
  /*
    */
;
/*
  */
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
  })(umobi);
  /*
    */
;
/*
  */
  u.ready(function() {
    var $a, $inner, $li, li, lis, listview, listviews, ulistview, _i, _len, _results;
    listviews = u.dom.queryAll('ul[data-role="listview"]');
    _results = [];
    for (_i = 0, _len = listviews.length; _i < _len; _i++) {
      listview = listviews[_i];
      ulistview = u(listview);
      listview.classList.add('ui-listview');
      if (ulistview.attr('data-inset')) {
        listview.classList.add('ui-listview-inset');
      }
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
  /*
    */
;
/*
  */
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
        this.element.addEventListener('touchstart', this, false);
        onTouchMove = self.onTouchMove;
        this.element.addEventListener('touchmove', function(e) {
          return onTouchMove.call(self, e);
        });
        this.element.addEventListener('touchend', this, false);
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
        if (debug) {
          return console.log('onTouchStart', {
            startTouchY: this.startTouchY,
            contentStartOffsetY: this.contentStartOffsetY
          });
        }
      };

      Scroller.prototype.onTouchMove = function(e) {
        var contentHeight, currentY, d, deltaY, newY, viewportHeight;
        this.prevTouchY = this.lastTouchY;
        this.lastTouchY = currentY = e.touches[0].clientY;
        if (!this.isDragging) {
          return;
        }
        if (this.viewportHeight() > this.contentHeight()) {
          return;
        }
        deltaY = currentY - this.startTouchY;
        newY = deltaY + this.contentStartOffsetY;
        /*
                        */

        d = this.getTouchDirection();
        if (d === 1) {
          if (newY > this.snapBoundary) {
            newY = this.snapBoundary;
          }
        } else if (d === -1) {
          contentHeight = this.contentHeight();
          viewportHeight = this.viewportHeight();
          if ((contentHeight + newY + this.snapBoundary) < viewportHeight) {
            newY = -contentHeight + (viewportHeight - this.snapBoundary);
          }
        }
        this.animateTo(newY);
        return this.contentLastOffsetY = newY;
      };

      Scroller.prototype.onTouchEnd = function(e) {
        if (debug) {
          console.log('onTouchEnd', e);
        }
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
        if (delta > 0) {
          return 1;
        }
        if (delta === 0) {
          return 0;
        }
        if (delta < 0) {
          return -1;
        }
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
        if (m.velocity < 0.2 && m.newY > 0) {
          return false;
        }
        if (this.overBottomSnapLimit(m.newY)) {
          return false;
        }
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
          if (debug) {
            console.log('Playing snaptobounds animation', framecss);
          }
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
        if (debug) {
          console.log("startMomentum", m);
        }
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
        } else if (d === 1) {
          return this.cubicBezierAnimateTo(this.snapDuration, 0);
        }
      };

      Scroller.prototype.generateCSSKeyframes = function(keyframes, name, time, offset) {
        var lines;
        lines = ['@-webkit-keyframes ' + name + ' {'];
        keyframes.forEach(function(keyframe) {
          var frame, percent;
          percent = (keyframe.time / time) * 100;
          frame = Math.floor(percent) + '% { ';
          frame += '-webkit-transform: ' + keyframe.transform + ';';
          if (keyframe.transition) {
            frame += '-webkit-transition: ' + keyframe.transition + ';';
          }
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
  /*
    */
;
/*
  */

  var support;
  support = {
    offlineCache: typeof window.applicationCache !== 'undefined',
    classList: typeof document.documentElement !== 'undefined',
    touchEnabled: navigator.userAgent.match(/(iPhone|iPad|Android|Mobile)/)
  };
  support.matrix = __indexOf.call(window, "WebKitCSSMatrix") >= 0;
  support.matrixM11 = umobi.support.matrix && (__indexOf.call(new WebKitCSSMatrix(), "m11") >= 0);
  umobi.support = support;
  /*
    */
;
/*
  */
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
  });
  /*
    */
;
/*
  */
  (function() {
    u('body').css('overflow', 'hidden').addClass('ui-overlay-c');
    return umobi.page = {
      findAll: function() {
        return u('[data-role="page"]');
      },
      findActive: function() {
        return u('.ui-page-active');
      },
      init: function() {
        var indexPage, pages,
          _this = this;
        $(document).trigger('pageinit');
        pages = this.findAll();
        if (!pages.get(0)) {
          pages = u($("body").wrapInner("<div data-role=\"page\"></div>").children(0).get(0));
        }
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
        if (!upage.get(0)) {
          upage = u('[data-role="page"]').first();
        }
        return umobi.page.reveal(upage);
      },
      create: function(el) {
        var $c, $contentContainer, AdjustContentHeight, AdjustContentPadding, c, f, h, isBothFixed, resizeTimeout, upage;
        upage = u(el);
        upage.trigger("pagecreate");
        upage.addClass(["ui-page", "ui-body-" + umobi.config.theme]);
        h = upage.find('[data-role="header"]').addClass("ui-header");
        f = upage.find('[data-role="footer"]').addClass("ui-footer");
        c = upage.find('[data-role="content"]').addClass("ui-content");
        h.find("h1,h2,h3,h4,h5,h6").addClass("ui-title");
        isBothFixed = h.data("fixed" || f.data("fixed"));
        if (isBothFixed) {
          $c = c.jQuery();
          $c.wrap('<div class="ui-content-container"/>');
          $contentContainer = $c.parent();
          if (!umobi.config.touchScroll) {
            AdjustContentPadding = function() {
              if (h.get(0)) {
                $contentContainer.css("paddingTop", h.height() + "px");
              }
              if (f.get(0)) {
                return $contentContainer.css("paddingBottom", f.height() + "px");
              }
            };
            upage.on("pagereveal", AdjustContentPadding);
          } else {
            AdjustContentHeight = function(e) {
              var contentBottom, contentHeight, contentTop;
              contentHeight = $(window).height();
              contentTop = h.get(0) ? h.height() : 0;
              contentBottom = f.get(0) ? f.height() : 0;
              return $contentContainer.css({
                position: "absolute",
                top: contentTop + "px",
                left: 0,
                bottom: contentBottom + "px",
                overflow: umobi.support.touchEnabled ? "hidden" : "auto"
              });
            };
            upage.on("pagereveal", AdjustContentHeight);
          }
        }
        resizeTimeout = null;
        u(window).on("resize", function() {
          if (resizeTimeout) {
            clearTimeout(resizeTimeout);
          }
          return resizeTimeout = setTimeout(AdjustContentHeight, 100);
        });
        if (h.attr("data-fixed")) {
          h.addClass("ui-fixed-header");
        }
        if (f.attr("data-fixed")) {
          return f.addClass("ui-fixed-footer");
        }
      }
    };
  })();
  /*
    */
;
/*
  */
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
        if ($.type(url) === "object") {
          return url;
        }
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
        if (relPath && relPath.charAt(0) === "/") {
          return relPath;
        }
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
              if (absStack.length) {
                absStack.pop();
              }
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
  /*
    */
;
define('cs!umobi.splitview',["cs!u", "cs!umobi.core", "cs!umobi.page"], function() {
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
});
/*
  */

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
  (function() {
    var initializeLinks;
    initializeLinks = function() {
      var link, ulink, _i, _len, _ref, _results;
      _ref = document.links;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        link = _ref[_i];
        ulink = u(link);
        if (!ulink.data('role')) {
          ulink.addClass('ui-link');
        }
        _results.push(ulink.click(function(e) {
          var href;
          href = ulink.attr('href');
          if (href.match(/^#\w+/)) {
            return umobi.page.revealByHash(href);
          }
        }));
      }
      return _results;
    };
    return u.ready(initializeLinks);
  })();
  /*
    */
;
/*
  */
  (function() {
    var uhtml;
    uhtml = u('html');
    uhtml.children(0).addClass(['ui-mobile', 'ui-mobile-rendering']);
    return u.ready(function() {
      var hideAddressBar;
      umobi.page.init();
      if (window.navigator.userAgent.match(/iPhone|iPad|Android/)) {
        hideAddressBar = function() {
          if (document.documentElement.scrollHeight < (window.outerHeight / window.devicePixelRatio)) {
            document.documentElement.style.height = (window.outerHeight / window.devicePixelRatio) + 'px';
          }
          return window.scrollTo(0, 1);
        };
        window.addEventListener("load", hideAddressBar);
        window.addEventListener("orientationchange", hideAddressBar);
        $(document).on('pagereveal', hideAddressBar);
      }
      u.load(function() {
        return uhtml.removeClass('ui-mobile-rendering');
      });
      return u(document.body).addClass("ui-body-c");
    });
  })();
  /*
    */
;

// load cs plugin and coffee-script
define('umobi',[
    "require",
    // "depend!zepto[]",
    // "z",
    "depend!define[]",
    "depend!jquery[]",
    "depend!classList[]",
    "cs",
    "coffee-script",
    "cs!str",
    "cs!umobi.core",
    "cs!u.dom",
    "cs!u",
    "cs!umobi.button",
    "cs!umobi.widget",
    "cs!umobi.zoom",
    "cs!umobi.listview",
    "cs!umobi.navigation",
    "cs!umobi.scroller",
    "cs!umobi.support",
    "cs!umobi.offlinecache",
    "cs!umobi.page",
    "cs!umobi.splitview",
    "cs!umobi.link",
    "cs!umobi.init"
], function(r,jQuery,cs,cs2,umobi) { 
    // r(["cs!umobi.init"]);
});

}));
