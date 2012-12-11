// query selector vs jquery
// http://jsperf.com/jquery-vs-queryselectorall-to-array
//
// get element by id vs query selector
// http://jsperf.com/getelementbyid-v-s-queryselector
define(["jquery","cs!umobi.core"],function($) {
    var dom = {  };
    dom.queryAll = function(q) {
        if( typeof document.querySelectorAll !== 'undefined' )
            return $(document.querySelectorAll(q));
        return $(q);
    };

    // get by id
    dom.get = function(id) {
        return $(document.getElementById(id));
    };

    // get by tagname
    dom.getTags = function(tag) {
        return $(document.getElementsByTagName(tag));
    };
    uMobi.dom = dom;
    return dom;
});
