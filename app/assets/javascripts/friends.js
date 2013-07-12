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
                allFriends  = shuffle(data).slice(0, 99);

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
            $('.friend-visible').removeClass('friend-visible');

            var i;

            for (i = 0; i < 9; i++) {
                friendsVisible += 1;
                $('.friend-' + friendsVisible).addClass('friend-visible');
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

            $(document).on('click', '.friend-container', handleFriendClick);
            $(document).on('click', '.show-more-friends', function(e) {
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







Handlebars.registerHelper('compare', function (lvalue, operator, rvalue, options) {

    var operators, result;

    if (arguments.length < 3) {
        throw new Error("Handlerbars Helper 'compare' needs 2 parameters");
    }

    if (options === undefined) {
        options = rvalue;
        rvalue = operator;
        operator = "===";
    }

    operators = {
        '==': function (l, r) { return l == r; },
        '===': function (l, r) { return l === r; },
        '!=': function (l, r) { return l != r; },
        '!==': function (l, r) { return l !== r; },
        '<': function (l, r) { return l < r; },
        '>': function (l, r) { return l > r; },
        '<=': function (l, r) { return l <= r; },
        '>=': function (l, r) { return l >= r; },
        'typeof': function (l, r) { return typeof l == r; }
    };

    if (!operators[operator]) {
        throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator);
    }

    result = operators[operator](lvalue, rvalue);

    if (result) {
        return options.fn(this);
    } else {
        return options.inverse(this);
    }

});