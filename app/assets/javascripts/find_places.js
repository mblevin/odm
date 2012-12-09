$(function() {
  $('div.save-place').hide();
  $('div.found-places').on('click','a',choosePlace);
  $('div.save-place').submit(savePlace)
});

function choosePlace (e) {
  console.log("Hello");
  e.preventDefault();
  var place = $(this).parent().parent();
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
  eventMonth = parseInt($('select#event_date_month').val(), 10) - 1;
  eventDay = parseInt($('select#event_date_day').val());
  eventYear = parseInt($('input#year').val());
  eventDate = new Date(eventYear, eventMonth, eventDay);
  gocoApp.placeDetails.title = $('input#title').val();
  gocoApp.placeDetails.description = $('textarea#description').val();
  gocoApp.placeDetails.date = eventDate;
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
