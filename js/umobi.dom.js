// query selector vs jquery
// http://jsperf.com/jquery-vs-queryselectorall-to-array
//
// get element by id vs query selector
// http://jsperf.com/getelementbyid-v-s-queryselector
define(["jquery","cs!umobi.core"],function($,umobi) {
    var dom = {  };
    dom.supportClassList = (typeof document.documentElement.classList !== 'undefined');

    dom.query = function(q,c) {
        c = c || document;
        return c.querySelector(q);
    };

    dom.queryAll = function(q,c) {
        c = c || document;
        // querySelectorAll is available in IE8, Chrome, Firefox and Safari
        // in this library we don't consider IE7
        return c.querySelectorAll(q);
    };

    // get element by id, which is faster than querySelectorAll
    dom.get = function(d,c) {
        c = c || document;
        return c.getElementById(d);
    };


    // convert element collection to array
    // which is needed when iterating huge collection.
    dom.collectionToArray = function(c) {
        var i = 0, len = c.length;
        var list = [];
        for (; i < len ; i++ ) {
            list.push(c[i]);
        }
        return list;
    };

    // get by tagname
    dom.byTagName = function(n,c) {
        c = c || document;
        return c.getElementsByTagName(n);
    };
    dom.byClassName = function(n,c) {
            c = c || document;
            return c.getElementsByClassName(n);
    };


    // http://jsperf.com/jquery-addclass-vs-dom-classlist/2
    dom.addClass = function(e,cls) {
        if(typeof e.classList !== 'undefined')
            e.classList.add(cls);
        // jquery fallback
        else $(e).addClass(cls);
    };

    dom.removeClass = function(e,cls) {
        if(this.supportClassList)
            e.classList.remove(cls);
        else $(e).removeClass(cls);
    };

    dom.toggleClass = function(e,cls) {
        if(this.supportClassList)
            e.classList.toggle(cls)
        else $(e).toggleClass(cls);
    };

    dom.bind = function(el,n,cb) {
        el.addEventListener(n,cb);
    };


    umobi.dom = dom;

    var u = function(a) {
        this.dom = dom;
        if( a instanceof NodeList ) {
            this.els = a;
            this.length = a.length;
        } else if( a instanceof Node ) {
            this.el = a;
        } else if (typeof a === "string") {
            this.els = this.dom.queryAll(a);
        } else {
            throw "u: unsupported argument"
        }
    };
    u.prototype = {
          size: function() {
            if(this.els) return this.els.length;
            if(this.el) return 1;
            return 0;
        }
        , get: function(i) {
            if(this.els) return this.els[i];
            else if (i == 0) return this.el;
        }
        , addClass: function(cls) {
            this.each(function(i,el) {
                dom.addClass(el,cls);
            });
            return this;
        }
        , removeClass: function(cls) {
            this.each(function(i,el) {
                dom.removeClass(el,cls);
            });
            return this;
        }
        , each: function(cb) {
            if(this.els) {
                var i = 0, len = this.els.length;
                for(;i < len; i++ ) cb(i,this.els[i]);
            } else {
                cb(0,this.el);
            }
            return this;
        }
        , toggleClass: function(cls) {
            this.each(function(i,el) {
                dom.toggleClass(el,cls);
            });
            return this;
        }
        , click: function(cb) {
            this.bind('click',cb);
            return this;
        }
        , bind: function(n,cb) {
            this.each(function(i,el) {
                el.addEventListener(n,cb);
            });
            return this;
        }
    };
    window.u = u;
    return dom;
});
