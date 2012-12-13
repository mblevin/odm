$(function() {
  // Sets the map on the page.
  var map = mapbox.map('map-canvas');
  map.zoom(8, true);
  map.addLayer(mapbox.layer().id('dcoates.map-frbb1lgm'));

  // Sets the markers on the map
  var markerLayer = mapbox.markers.layer().features(gocoApp.markers);
  map.addLayer(markerLayer);

  $('div.event').click(getEvent);

  $.ajax({
    type: "GET",
    url: "/get_event",
    data: { map_id: $('meta[name="map_id"]').attr('content')
          }
    }).done(function( msg ) {
      console.log(msg);
      gocoApp.events = msg;
    });
});

function getEvent () {
  var eventId = $(this).attr('id');


}