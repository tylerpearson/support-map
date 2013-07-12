var App = App || {};

App.friends = (function($) {

    "use strict";

    var friendsData = [],

        // API ACCESS POINTS
        api = {
            getFriends: "/api/friends.json"
        },

        handleFriends = function(data) {
            friendsData = data;

            var source   = $("#friend-template").html(),
                template = Handlebars.compile(source),
                html     = template(friendsData);

            $('.big-content').append(html);
            $('body').addClass('main-open');

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
        handleFriendClick = function() {
            $(this).toggleClass('friend-selected');
        };


    return {
        init: function() {
            console.log("FRIENDS ARE STARTING!");
            getFriends();

            $(document).on('click', '.friend-container', handleFriendClick);
        }
    };


}(jQuery));