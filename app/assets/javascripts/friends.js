var App = App || {};

App.friends = (function ($, App, Handlebars) {

    "use strict";

    var allFriends = [],
        friendsVisible = 9 - 1,

        $elems = {
            body: $('body'),
            loading: $('.loading')
        },

        api = {
            getFriends: "/api/friends.json",
            addInvitation: "/api/invitations.json"
        },

        handleFriends = function (data) {

            if (data.length) {
                allFriends  = shuffle(data);

                var source   = $("#friends-template").html(),
                    template = Handlebars.compile(source),
                    html     = template(allFriends);

                $elems.body.addClass('main-open');

                $('.big-content').html(html);
                $('.friends-count').text(data.length);
            } else {
                hideFriendsSection();
            }
            App.util.loadingHide(250);
        },
        showMoreFriends = function () {
            var i;

            $('.friend-visible').removeClass('friend-visible');

            for (i = 0; i < 9; i++) {
                friendsVisible += 1;
                if (friendsVisible !== allFriends.length) {
                    $('.friend-' + friendsVisible).addClass('friend-visible');
                } else {
                    friendsVisible = 0 - 1;
                    break;
                }
            }
        },
        getFriends = function () {
            App.util.loadingShow(250);
            $.ajax({
                type: "GET",
                dataType: "json",
                url: api.getFriends,
                success: function(data) {
                    handleFriends(data);
                }
            });
        },
        handleFriendClick = function(elem) {
            var $this = $(elem),
                friend = {
                    firstName: $this.data('firstname'),
                    lastName: $this.data('lastname'),
                    name: $this.data('name'),
                    uid: $this.data('uid')
                },
                linkURL = window.location.href;

            $this.toggleClass('friend-selected');

            FB.ui({
                method: 'feed',
                to: friend.uid,
                name: friend.firstName + ', join me in supporting this candidate!',
                caption: 'FriendtheVote.com',
                description: 'I just committed to vote for this candidate. Election Day is November 6 &mdash; make a difference this year and join us.',
                link: linkURL,
                // picture: fbImageUrl,
                actions: [{ name: 'Commit to vote too', link: linkURL }],
                user_message_prompt: 'Tell your friends to vote'
            }, function (response) {
                if (response && response.post_id) {
                    sendInvitationNotification(friend.uid, $this);
                }
            });

        },
        sendInvitationNotification = function(friendId, elem) {
            $.ajax({
                type: "POST",
                dataType: "html",
                data: {friend_uid: friendId},
                url: api.addInvitation
            }).done(function() {
                elem.addClass('notified');
            });
        };

    return {
        init: function() {
            getFriends();

            $(document)
                .on('click', '.friend-container', function(e) {
                    e.preventDefault();
                    handleFriendClick(this);
                })
                .on('click', '.show-more-friends', function(e) {
                    e.preventDefault();
                    showMoreFriends();
                });
        },
        hideFriendsSection: function() {
            $elems.body.removeClass('main-open').removeClass('cover-open');
        }
    };


    // Helper functions
    function shuffle(o) {
        for(var j, x, i = o.length; i; j = parseInt(Math.random() * i, 10), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    }


}(jQuery, App, Handlebars));