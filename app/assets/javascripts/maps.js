var App = App || {};

App.maps = (function($, App) {

    "use strict";

    window.map = L.mapbox.map('map', 'tylerpearson.map-6y1babfo');

    var markers = new L.MarkerClusterGroup(),
        addressPoints = gon.endorsements.features;

    return {
        addMarker: function(lat, lng, title, description) {
            L.mapbox.markerLayer({
                type: "Feature",
                geometry: {
                    type: "Point",
                    coordinates: [lng, lat]
                },
                properties: {
                    title: title,
                    description: description,
                    "marker-size": "medium",
                    "marker-color": "#68c14d"
                }
          }).addTo(window.map);
        },
        setUpMap: function(lat, lng) {

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

            map.addLayer(markers).setView([lat, lng], 8);
        },
        init: function() {
            App.maps.setUpMap(37.948,-79.767);
        }
    };


}(jQuery, App));