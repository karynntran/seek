var origins = []
var destinations = []
function fetchData(){

  $.ajax({
    url: '/autocomplete',
    dataType: 'json',
    success: function(data) {
      origins = data.origin;
      destinations = data.destination;
      destinationComplete();
    }
  });
}

function destinationComplete(){
  $("#destination").autocomplete({
    source: destinations
  });
}

$(function(){
  fetchData()
});