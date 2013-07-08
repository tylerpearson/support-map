# Main map page setup

$(document).ready ->

  $editUser = $(".edit_user")

  hideMain = ->
    $('body').addClass('hide-main')

  if $.cookie("added_name")
    hideMain()

  $editUser.on("ajax:success", (e, data, status, xhr) ->
    hideMain()
  ).bind "ajax:error", (e, xhr, status, error) ->
    $('.content').html "<p class=\"error\">Error. Please try again.</p>"
