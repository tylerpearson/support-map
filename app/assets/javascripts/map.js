// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


(function() {

  var map = L.mapbox.map('map', 'tylerpearson.map-6y1babfo'),
      markers = new L.MarkerClusterGroup(),
      addressPoints = gon.endorsements.features;

  for (var i = 0; i < addressPoints.length; i++) {

    var a = addressPoints[i],
        title = a.properties.title,
        marker = L.marker(new L.LatLng(a.geometry.coordinates[1], a.geometry.coordinates[0]), {
            icon: L.mapbox.marker.icon({'marker-color': '2c64da', 'marker-size': 'small' }),
            title: title
        });

    marker.bindPopup(title);
    markers.addLayer(marker);
  }

  map.addLayer(markers);

}());


