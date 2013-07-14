var App = App || {};

App.util = (function($, App) {

    "use strict";

    var $elems = {
        body: $('body')
    };

    return {
        hideMain: function(hideCover) {
            $elems.body.addClass('hide-main');
            if (hideCover === true) {
                $elems.body.removeClass('cover-open');
            }
        }
    };


}(jQuery, App));