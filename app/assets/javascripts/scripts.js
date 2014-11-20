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
      originComplete();
    }
  });
}


function destinationComplete(){
  $("#destination").autocomplete({
    source: destinations
  });
}


function originComplete(){
  $("#origin").autocomplete({
    source: origins
  });
}

function validateDestination() {
  $("#destination").on('keyup', function(){
    if ($.inArray($(this).val(), destinations) > -1) {
      $("#origin_label").show();
      $("#origin").show();
    }
  });
}

function changeBackground(){
  $('#slideshow').cycle({
    fx: 'fade',
    pager: '#smallnav', 
    pause:   1, 
    speed: 1800,
    timeout:  3500 
  });
};









// *********  show page backgrounds **********
