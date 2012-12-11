define(["jquery","cs!umobi.core"],function($) {
    var dom = {  };
    dom.queryAll = function(q) {
        if( typeof document.querySelectorAll !== 'undefined' )
            return $(document.querySelectorAll(q));
        return $(q);
    };
    dom.get = function(id) {
        return $(document.getElementById(id));
    };
    uMobi.dom = dom;
    return dom;
});
