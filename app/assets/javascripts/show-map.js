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
});

function displayEvent () {
  var eventId = $(this).attr('id'),
      eventLat = gocoApp.events[eventId].latitude,
      eventLon = gocoApp.events[eventId].longitude;

  //On click, bring up the location
  gocoApp.map.ease.location({
                            lat: parseFloat(eventLat),
                            lon: parseFloat(eventLon) }
                            ).zoom(15).optimal();

  //Remove selected class from anything that is selected.
  $('.selected').removeClass('selected');
  //Add it to clicked event (div).
  $(this).addClass('selected');
  displayEventDetails(this);
}

function displayEventDetails (selectedDiv) {
  $('div.event-description').empty();
}