$editUser = $(".edit_user")

$editUser.on("ajax:success", (e, data, status, xhr) ->
  $editUser.append xhr.responseText
).bind "ajax:error", (e, xhr, status, error) ->
  $editUser.append "<p>Error</p>"