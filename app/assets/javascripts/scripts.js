var origins = []
var destinations = []
var fadeTime = 300

function expandLogin() {
    $("#login").on('click', function(){
        $("#user_username").fadeIn(400);
        $("#user_password").fadeIn(400);
        $(this).text('Sign Up')
    });
}

function ajaxLogin() {
    $("#expanded_login").on('click', function(e) {
        e.preventDefault();
        $.ajax({
            method: 'post',
            url: '/sessions',
            dataType: 'json',
            data: {user: { username: $("#user_username").val(), password: $("#user_password").val() }},
            success: function(data) {
                debugger
            }
        });
    });
}

function fetchData() {

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
      // $("#origin_label").fadeIn(200);
      $("#destination_error").fadeOut(fadeTime);
      $("#origin").fadeIn(fadeTime);
    }
  });
};

function validateOrigin() {
  $("#origin").on('keyup', function(){
    if ($.inArray($(this).val(), origins) > -1) {
      $("#origin_error").fadeOut(fadeTime);
      showMonthandGo();      
    } 
  });
};

function showMonthandGo() {
  $("#month_label").fadeIn(fadeTime);
  $("#month").fadeIn(fadeTime);
  $("input:submit").fadeIn(fadeTime);
  setInterval(function() { validateAll(); },1000) 
}

// function clickGo() {
//   .on('click', function(e){
//     if (!validateAll()) {
//       e.preventDefualt();
//     }
//   });
// };

function validateAll() {
  if ($.inArray($("#origin").val(), origins) === -1) {
    $("#origin_error").fadeIn(600);
  } 
  if ($.inArray($("#destination").val(), destinations) === -1) {
    $("#destination_error").fadeIn(600);
  }
  if (($.inArray($("#origin").val(), origins) > -1) && ($.inArray($("#destination").val(), destinations) > -1)) {
    $("input:submit").prop( "disabled", false );
    return true;
  } else {
    $("input:submit").prop( "disabled", true );
    return false;
  }
};

function changeBackground(){
  $('#slideshow').cycle({
    fx: 'fade',
    speed: 1800,
    timeout:  3500 
  });
};

function loadSearchPage() {
    ajaxLogin();
    fetchData();
    $("input:submit.go").prop( "disabled", true );
    validateDestination();
    validateOrigin();
    changeBackground();
    expandLogin();
};


// *********  show page backgrounds **********

// *********  flickr backgrounds **********

function cycleImages(){
  $('#cycle-photos').cycle({
    fx: 'fade',
    speed: 1200,
    timeout:  3500 
  });
};
