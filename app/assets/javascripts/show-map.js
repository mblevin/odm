//dcoates.map-frbb1lgm <-- map-id
//var map = mapbox.map('map');
$(function() {
  var map = mapbox.map('map-canvas');
  map.zoom(8, true);
  map.addLayer(mapbox.layer().id('dcoates.map-frbb1lgm'));

  // mapbox.auto('map-canvas', 'dcoates.map-frbb1lgm');
  var markerLayer = mapbox.markers.layer().features(gocoApp.markers);
  map.addLayer(markerLayer);
});

