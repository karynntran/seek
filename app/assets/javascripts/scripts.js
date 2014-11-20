var origins = []
var destinations = []
$.ajax({
  url: '/autocomplete',
  dataType: 'json',
  success: function(data) {
    origins = data.origin;
    destinations = data.destination;
  }
});