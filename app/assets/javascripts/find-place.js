$(function() {
  $('div.save-place').hide();
  $('form.new-place').hide();
  $('div.found-places').on('click','div.select-link a',choosePlace);
  $('div.found-places').on('click','div.no-places-found a',noPlacesFound);
  $('form.new-place').submit(createPlace);

  $('div.save-place #map_id').val($('meta[name="map_id"]').attr('content'));
});


//If anything is returned from Foursquare and a user selects a place.
function choosePlace (e) {
  e.preventDefault();
  var place = $(this).parent().parent();
  gocoApp.placeDetails.latitude = place.data('lat');
    gocoApp.placeDetails.longitude = place.data('lng');
    gocoApp.placeDetails.place_name = place.find('.place-name').text();

  //Set hidden form fields as values we just created.
  $('div.save-place #place_name').val(gocoApp.placeDetails.place_name);
  $('div.save-place #latitude').val(gocoApp.placeDetails.latitude);
  $('div.save-place #longitude').val(gocoApp.placeDetails.longitude);

  //Check to see if there are street view images.
  checkStreetView(gocoApp.placeDetails.latitude, gocoApp.placeDetails.longitude);

  //Reset the page.
  $('div.found-places').empty().hide();
  $('div.save-place h3').text(gocoApp.placeDetails.place_name);
  $('div.save-place').show();
}


//If no place is found on Foursquare
function noPlacesFound () {
  $('div.found-places').hide();
  $('form.new-place').show();
}

//Create a place if none exist.
function createPlace (e) {
  e.preventDefault();
  $('form.new-place h3').text("New Place"); //In case we reset it.
  var geocoder = new google.maps.Geocoder();
  var address = $('input#address').val();

  //Get the lat and long from Google.
  geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        var longitude = results[0].geometry.location['$a'],
            latitude = results[0].geometry.location['ab'];
        $('div.save-place #place_name').val($('input#new_place_name').val());
        $('div.save-place #latitude').val(latitude);
        $('div.save-place #longitude').val(longitude);

        //Check to see if there is street view imagery.
        checkStreetView(latitude, longitude);

        //Reset the create place area and set up the save place area.
        $('input#new_place_name').val('');
        $('input#address').val('');
        $('form.new-place').hide();
        $('div.save-place h3').text(gocoApp.placeDetails.place_name);
        $('div.save-place').show();
      } else {
        $('form.new-place h3').text("No place found. Try again.");
        console.log("Geocode was not successful for the following reason: " + status);
      }
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
  var streetViewMaxDistance = 40;

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
        console.log("none");
        $('div.save-place #street_view_heading').val(0);
      }
      else{
        var oldPoint = point;
        point = streetViewPanoramaData.location.latLng;
        var heading = google.maps.geometry.spherical.computeHeading(point,oldPoint);
        $('div.save-place #street_view_heading').val(heading);
      }
  });
}