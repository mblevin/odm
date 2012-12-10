$(function() {
  $('div.save-place').hide();
  $('form.new-place').hide();
  $('div.found-places').on('click','div.select-link a',choosePlace);
  $('div.found-places').on('click','div.no-places-found a',noPlacesFound);
  $('div.save-place').submit(savePlace);
  $('form.new-place').submit(createPlace);
});


function choosePlace (e) {
  e.preventDefault();
  var place = $(this).parent().parent();
  gocoApp.placeDetails.latitude = place.data('lat'),
    gocoApp.placeDetails.longitude = place.data('lng'),
    gocoApp.placeDetails.place_name = place.find('.place-name').text();
  checkStreetView(gocoApp.placeDetails.latitude, gocoApp.placeDetails.longitude);
  $('div.found-places').empty().hide();
  $('div.save-place h3').text(gocoApp.placeDetails.place_name);
  $('div.save-place').show();
}

function noPlacesFound () {
  $('div.found-places').hide();
  $('form.new-place').show();
}

function createPlace (e) {
  e.preventDefault();
  $('form.new-place h3').text("New Place"); //In case we reset it.
  var geocoder = new google.maps.Geocoder();
  var address = $('input#address').val();
  geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        gocoApp.placeDetails.place_name = $('input#new_place_name').val();
        gocoApp.placeDetails.latitude = results[0].geometry.location['ab'];
        gocoApp.placeDetails.longitude = results[0].geometry.location['$a'];
        checkStreetView(gocoApp.placeDetails.latitude, gocoApp.placeDetails.longitude);

        //Reset the create place area and set up the save place area.
        $('input#new_place_name').val('');
        $('input#address').val('');
        $('form.new-place').hide();
        $('div.save-place h3').text(gocoApp.placeDetails.place_name);
        $('div.save-place').show();
      } else {
        $('form.new-place h3').text("No place found. Try again."); //In case we reset it.
        console.log("Geocode was not successful for the following reason: " + status);
      }
    });

}

function savePlace (e) {
  e.preventDefault();
  gocoApp.placeDetails.map_id = $('meta[name="map_id"]').attr('content'); //Getting the map ID.
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
        source: "",
        placeDetails: gocoApp.placeDetails
      }
      }).done(function( msg ) {
        resetNewEventPage();
        renderExistingEvents(msg);
    });
}

function resetNewEventPage () {
  $('div.save-place input#title').val('');
  $('div.save-place textarea#description').val('');
  $('div.find-place input[type=text]').val('');
  $('div.save-place').hide();
}

function renderExistingEvents (data) {
  if (data) {
    $('div.events').empty();
    var dataLength = data.length;
    for (var i = 0; i < dataLength; i++) {
      var div = $('<div>').addClass('event'),
          titleSpan = $('<span>').addClass('event-title'),
          descriptionSpan = $('<span>').addClass('event-description');

      $(titleSpan).text(data[i].title);
      $(descriptionSpan).text(data[i].description);
      $('div.events').append($(div).append(titleSpan).append(descriptionSpan));
    };
  };
}

function checkStreetView (lat, lng) {
  //Many thanks to: http://stackoverflow.com/a/8381895
  var streetViewMaxDistance = 100;

  var point = new google.maps.LatLng(lat, lng);
  var mapOptions = {
      center: point,
      zoom: 16,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      streetViewControl: false
    };
  //We have to create a map even though we aren't using it.
  var map = new google.maps.Map(document.getElementById('hidden_map'),
        mapOptions);
  var streetViewService = new google.maps.StreetViewService();
  var panorama = map.getStreetView();

  streetViewService.getPanoramaByLocation(point, streetViewMaxDistance, function (streetViewPanoramaData, status) {
      if(status !== google.maps.StreetViewStatus.OK){
        gocoApp.placeDetails.street_view = heading;
      }
      else{
        var oldPoint = point;
        point = streetViewPanoramaData.location.latLng;
        var heading = google.maps.geometry.spherical.computeHeading(point,oldPoint);
        gocoApp.placeDetails.street_view_heading = heading;
      }
  });
}