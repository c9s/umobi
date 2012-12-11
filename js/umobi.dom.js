// query selector vs jquery
// http://jsperf.com/jquery-vs-queryselectorall-to-array
//
// get element by id vs query selector
// http://jsperf.com/getelementbyid-v-s-queryselector
define(["jquery","cs!umobi.core"],function($,umobi) {
    var dom = {  };
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

    // get by tagname
    dom.getTags = function(n,c) {
        c = c || document;
        return c.getElementsByTagName(n);
    };

    umobi.dom = dom;
    return dom;
});
