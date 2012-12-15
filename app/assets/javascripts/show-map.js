$(function() {
  $('div.event').click(displayEvent);

  //Pre-fetch all events so we can load them quickly.
  $.ajax({
    type: "GET",
    url: "/get_event",
    data: { map_id: $('meta[name="map_id"]').attr('content')
          }
    }).done(function( msg ) {
      gocoApp.events = msg;
    });

  $('div.event-details').addClass('invisible');
});

function showMap(latitude, longitude) {
  gocoApp.map = mapbox.map('map-canvas');
  gocoApp.map.centerzoom({lat: latitude, lon: longitude}, 7);
  gocoApp.map.addLayer(mapbox.layer().id('dcoates.map-frbb1lgm'));

  var markerLayer = mapbox.markers.layer().features(gocoApp.markers).factory(function(f) {
    // Define a new factory function. This takes a GeoJSON object
    // as its input and returns an element - in this case an image -
    // that represents the point.
        var img = document.createElement('img');
        img.className = 'marker-image';
        img.setAttribute('src', f.properties.image);
        return img;
    });;

  gocoApp.map.addLayer(markerLayer);
}

function displayEvent () {
  var eventId = $(this).attr('id'),
      currentEvent = gocoApp.events[eventId],
      eventLatitude = currentEvent.latitude,
      eventLongitude = currentEvent.longitude;

  //On click, bring up the location on the map or on streetview.
  if (currentEvent.street_view_heading !== 0) {
    //Set street view if available.
    $('div#street-view').removeClass('invisible');
    $('div#map-canvas').addClass('invisible');

    //Below code largely straight from Google.
    var currentPlace = new google.maps.LatLng(currentEvent.latitude, currentEvent.longitude);
    var panoramaOptions = {
      position:currentPlace,
      pov: {
        heading: currentEvent.street_view_heading,
        pitch:0,
        zoom:1
      }
    };
    var myPano = new google.maps.StreetViewPanorama(document.getElementById('street-view'), panoramaOptions);
    console.log(myPano);
    myPano.setVisible(true);
  } else{
    showMap(eventLatitude, eventLongitude);
    $('div#street-view').addClass('invisible');
    $('div#map-canvas').removeClass('invisible');
    gocoApp.map.ease.location({
                              lat: parseFloat(eventLatitude),
                              lon: parseFloat(eventLongitude) }
                              ).zoom(15).optimal();
  };

  //Remove selected class from anything that is selected.
  $('.selected').removeClass('selected');
  //Add it to clicked event (div).
  $(this).addClass('selected');
  displayEventDetails(this);
}

function displayEventDetails (selectedDiv) {
  $('div.event-details').removeClass('invisible');

  var eventId = $(selectedDiv).attr('id'),
      currentEvent = gocoApp.events[eventId],
      eventPhoto = currentEvent.photo_url.url;

  $('h1#event-title').text(currentEvent.place_name);
  $('span#event-date').text(currentEvent.date);
  $('div.event-description p').text(currentEvent.description);

  if (eventPhoto) {
    var img = $("<img>").attr("src", eventPhoto);
    $('div.event-photo').html(img).show();
  } else{
    $('div.event-photo').empty();
  };

}