# Main map page setup

$(document).ready ->

  $editUser = $(".edit_user")

  hideMain = ->
    $('body').addClass('hide-main')

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
    console.log "added"

  if $.cookie("added_name")
    hideMain()

  $('.update-endorsement-form').on 'submit', (e) ->
    $('.endorsement-submit').attr('disabled','disabled').val('Submitting...')


  $editUser.on("ajax:success", (e, data, status, xhr) ->
    hideMain()
    console.log(data)
    addMarker(data.latitude, data.longitude, data.name, data.comment)
  ).bind "ajax:error", (e, xhr, status, error) ->
    $('.endorsement-submit').removeAttr('disabled')
    $('.content').html "<p class=\"error\">Error. Please try again.</p>"
