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

function changeBackground(){
  $('#slideshow').cycle({
    fx: 'fade',
    pager: '#smallnav', 
    pause:   1, 
    speed: 1800,
    timeout:  3500 
  });
};

$(function(){
  fetchData()
  changeBackground()  
});




// *********  show page backgrounds **********
