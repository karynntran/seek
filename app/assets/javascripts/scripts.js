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

function validateOrigin() {
  $("#origin").on('keyup', function(){
    if ($.inArray($(this).val(), origins) > -1) {
      $("#month_label").show();
      $("#month").show();
      $(".show")
    }
  });
}




$(function(){
  fetchData();
  validateDestination();
  validateOrigin(); 
});



// *********  show page backgrounds **********
