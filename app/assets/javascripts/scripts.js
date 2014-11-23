var origins = []
var destinations = []
var fadeTime = 300

function expandLogin() {
    $("#login").on('click', function(){
        $("#user_username").fadeIn(400).focus();
        $("#user_password").fadeIn(400);
        $("#expanded_login").fadeIn(400);
        $(this).text('First Time?').css('background-color', 'white').css('color', '#3867be')
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
            success: loginSuccess
        });
    });
}

function loginSuccess(data) {
    if (data.login === 'failed') {
        $("#expanded_login").effect('shake');
    } else {
        $("#new_user").fadeOut(fadeTime);
        $("#login").text(data.login).on('click', function(){
            window.location.href='/users/' + data.id
        });
    }
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
    source: destinations,
    select: function(event, ui) {
        validateDestination(ui.item.value);
    }
  });
}


function originComplete(){
  $("#origin").autocomplete({
    source: origins,
    select: function(event, ui) {
        validateOrigin(ui.item.value);
    }

  });
}

function inputListener() {
    $("#destination").on('keyup', function(){validateDestination($(this).val());});
    $("#origin").on('keyup change', function(){validateOrigin($(this).val());});
}


function validateDestination(value) {
    if ($.inArray(value, destinations) > -1) {
      // $("#origin_label").fadeIn(200);
      $("#destination_error").fadeOut(fadeTime);
      $("#origin").fadeIn(fadeTime).focus();
    }
}

function validateOrigin(value) {
    if ($.inArray(value, origins) > -1) {
      $("#origin_error").fadeOut(fadeTime);
      showMonthandGo();      
    } 
};

function showMonthandGo() {
  $("#month_label").fadeIn(fadeTime);
  $("#month").fadeIn(fadeTime).focus();
  $(".go").fadeIn(fadeTime);
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
    inputListener();
    $("input:submit.go").prop( "disabled", true );
    validateDestination();
    validateOrigin();
    changeBackground();
    expandLogin();
};


// *********  flickr images **********

function cycleImages(){
  $('#cycle-photos').cycle({
    fx: 'fade',
    speed: 1200,
    timeout:  3500 
  });
};

// *********  favorites scripts **********


function addFavoritesColor() {
  console.log(':)');
  $(".star").on('click', function(){
    $(this).css({
        'background-color': 'darkgray',
        'color': 'lightgray',
    });
    $(this).html("[X] Remove from favorites");
  });
}

// function addFavorites(){
//   console.log('favorite');
//   $.ajax {
//     url: 'users/favorites',
//     method: PATCH,
//     dataType:
//     success: function(data){
//       var url = document.URL
//     }
//   }
// }

