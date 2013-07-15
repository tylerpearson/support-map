# Main map page setup

$(document).ready ->

  if $.cookie("added_name")
    App.util.hideMain(true)

  $(document).on 'click', '.js-continue-link', (e) ->
    App.util.hideMain(true)

  $('.update-endorsement-form').on 'submit', (e) ->
    $('.endorsement-submit').attr('disabled','disabled').val('Submitting...')


  $editUser = $(".edit_user")

  $editUser.on("ajax:success", (e, data, status, xhr) ->
    App.util.hideMain(false)
    App.maps.addMarker(data.latitude, data.longitude, data.name, data.comment)
    App.friends.init();
  ).bind "ajax:error", (e, xhr, status, error) ->
    $('.endorsement-submit').removeAttr('disabled')
    $('.content').html "<p class=\"error\">Error. Please try again.</p>"


  App.maps.init();

