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

    umobi.dom = dom;

    var u = function(a) {
        this.dom = dom;
        if( a instanceof NodeList ) {
            this.elements = a;
            this.length = a.length;
        } else if( a instanceof Node ) {
            this.element = a;
        } else if (typeof a === "string") {
            this.elements = this.dom.queryAll(a);
        } else {
            throw "u: unsupported argument"
        }
    };
    u.prototype = {
        addClass: function(cls) {
            if(this.element) {
                dom.addClass(this.element,cls);
            } else if (this.elements) {
                var i = 0, len = this.length;
                for(; i < len; i++ ) {
                    dom.addClass(this.elements[i],cls);
                }
            }
            return this;
        },
        removeClass: function(cls) {
            if(this.element) {
                dom.removeClass(this.element,cls);
            } else if (this.elements) {
                var i = 0, len = this.length;
                for(; i < len; i++ ) {
                    dom.removeClass(this.elements[i],cls);
                }
            }
            return this;
        },
        toggleClass: function(cls) {
            if(this.element) {
                dom.toggleClass(this.element,cls);
            } else if (this.elements) {
                var i = 0, len = this.lenght;
                for(;i < len; i++ ) {
                    dom.toggleClass(this.elements[i],cls);
                }
            }
        }
    };
    window.u = u;
    return dom;
});
