$(function() {
  $('div.save-place').hide();
  $('div.found-places').on('click','a',choosePlace);
});

var place;

function choosePlace (e) {
  console.log("Hello");
  e.preventDefault();
  place = $(this).parent().parent();
  gocoApp.placeDetails.latitude = place.data('lat'),
    gocoApp.placeDetails.longitude = place.data('lng'),
    gocoApp.placeDetails.place_name = place.find('.place-name').text(),
    gocoApp.placeDetails.map_id = $('meta[name="map_id"]').attr('content');

  $('div.found-places').hide();
  $('div.save-place h3').text(gocoApp.placeDetails.place_name);
  $('div.save-place').show();
}

function savePlace (e) {
  e.preventDefault();
  eventDate =
  gocoApp.placeDetails.title = $('input#title').val();
  gocoApp.placeDetails.description = $('input#description').val();
  gocoApp.placeDetails.date = $('input#event_date').val();
  $.ajax({
      type: "POST",
      url: "/save_event",
      data: {
        placeDetails: gocoApp.placeDetails
      }
      }).done(function( msg ) {
        console.log(msg);
    });
}
