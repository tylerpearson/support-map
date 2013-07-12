var App = App || {};


App.friends = (function($) {

    "use strict";

    var friendsData = [],

        api = {
            getFriends: "/api/friends.json"
        },

        handleFriends = function(data) {
            friendsData = data;
            console.log(friendsData);
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
        };




    return {
        init: function() {
            console.log("FRIENDS ARE STARTING!");
            getFriends();
        }
    };


}(jQuery));