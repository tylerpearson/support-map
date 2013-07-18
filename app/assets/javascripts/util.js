var App = App || {};

App.util = (function($, App) {

    "use strict";

    var $elems = {
        body: $('body'),
        loading: $('.loading')
    };

    return {
        hideMain: function(hideCover) {
            $elems.body.addClass('hide-intro');
            if (hideCover === true) {
                $elems.body.removeClass('cover-open');
            }
            if ($elems.body.hasClass('main-open')) {
              App.friends.hideFriendsSection();
            }
        },
        loadingShow: function(duration) {
            $elems.loading.fadeIn(duration);
        },
        loadingHide: function(duration) {
            $elems.loading.fadeOut(duration);
        }
    };


}(jQuery, App));