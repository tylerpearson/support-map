var App = App || {};

App.friends = (function($, App, Handlebars) {

    "use strict";

    var allFriends = [],
        friendsVisible = 9 - 1,

        $elems = {
            body: $('body')
        },

        api = {
            getFriends: "/api/friends.json"
        },

        handleFriends = function(data) {
            if (data.length) {
                allFriends  = shuffle(data);

                var source   = $("#friends-template").html(),
                    template = Handlebars.compile(source),
                    html     = template(allFriends);

                $('.big-content').append(html);
                $elems.body.addClass('main-open');
                $('.friends-count').text(data.length);
            } else {
                hideFriendsSection();
            }
        },
        showMoreFriends = function() {
            var i;

            $('.friend-visible').removeClass('friend-visible');

            for (i = 0; i < 9; i++) {
                friendsVisible += 1;
                if (friendsVisible !== allFriends.length) {
                    $('.friend-' + friendsVisible).addClass('friend-visible');
                } else {
                    friendsVisible = 0 - 1;
                    continue;
                }
            }
        },
        getFriends = function() {
            $.ajax({
                type: "GET",
                dataType: "json",
                url: api.getFriends,
                success: function(data) {
                    handleFriends(data);
                }
            });
        },
        hideFriendsSection = function() {
            $elems.body.removeClass('main-open').removeClass('cover-open');
        },
        handleFriendClick = function() {
            $(this).toggleClass('friend-selected');
        };


    return {
        init: function() {
            getFriends();

            $(document)
                .on('click', '.friend-container', handleFriendClick)
                .on('click', '.show-more-friends', function(e) {
                    e.preventDefault();
                    showMoreFriends();
                });
        }
    };


    // Helper functions
    function shuffle(o) {
        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i, 10), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    }


}(jQuery, App, Handlebars));