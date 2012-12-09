$(function() {
  $('div.find-place button').click(getPlaces);
  $('div.found-places').on('click','a',savePlace);
});

function getPlaces () {
  //Get data from the server before rendering it.
  $.ajax({
  type: "POST",
  url: "/find_place",
  data: { place: $('input#place').val(),
          city: $('input#city').val()}
  }).done(function( msg ) {
    var places = msg,
        placesLength = places.length;
    for (var i = 0; i < placesLength; i++){
      //Creating the HTML elements.
      var place = places[i],
          div = $('<div>').addClass('found-place').attr('data-lat', place['location']['lat']).attr('data-lng', place['location']['lng']),
          name = $('<h3>').addClass('place-name').text(place['name']),
          cityName = place['location']['city'] || "",
          citySpan = $('<span>').addClass('city').text(cityName),
          selectLink = $('<a>').text('Select').attr('href', '#').addClass('select-link');

      $(div).append(name).append(citySpan).append(selectLink);
      $('div.found-places').append(div);
    }
  });
}

function savePlace (e) {
  e.preventDefault();
  console.log($(this).parent());
  //this.parent get data lat, data long. get text of element with class 'place-name'
}