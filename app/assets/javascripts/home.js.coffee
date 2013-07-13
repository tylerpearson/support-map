# Main map page setup

$(document).ready ->

  $editUser = $(".edit_user")

  hideMain = (hideCover) ->
    $('body').addClass('hide-main')
    if hideCover is true
      $('body').removeClass('cover-open')

  addMarker = (lat, lng, title, description) ->
    L.mapbox.markerLayer(
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [lng, lat]

      properties:
        title: title
        description: description
        "marker-size": "medium"
        "marker-color": "#68c14d"
    ).addTo window.map

  if $.cookie("added_name")
    hideMain(true)

  $('.continue-link').click ->
    hideMain(true)

  $('.update-endorsement-form').on 'submit', (e) ->
    $('.endorsement-submit').attr('disabled','disabled').val('Submitting...')


  $editUser.on("ajax:success", (e, data, status, xhr) ->
    hideMain(false)
    addMarker(data.latitude, data.longitude, data.name, data.comment)
    App.friends.init();
  ).bind "ajax:error", (e, xhr, status, error) ->
    $('.endorsement-submit').removeAttr('disabled')
    $('.content').html "<p class=\"error\">Error. Please try again.</p>"

