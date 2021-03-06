var origins = []
var destinations = []
var fadeTime = 300

function changeBackground(){
    $('#slideshow').cycle({
        fx: 'fade',
        speed: 1800,
        timeout:  3500 
    });
}

function checkUser() {
    $.ajax({
        method: 'get',
        url: '/checkuser',
        dataType: 'json',
        success: loginSuccess
    });
}

function expandLogin() {
    $(".login_button").on('click', function(){
        $("#user_username").fadeIn(400).focus();
        $("#user_password").fadeIn(400);
        $("#expanded_login").fadeIn(400);
        $(this).text('First Time?')
            .css('background-color', 'white')
            .css('color', '#3867be')
            .switchClass('login_button', 'signup_button');
        expandSignup();
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
    if (data.status === 'failed') {
        $("#expanded_login").is(":visible") && $("#expanded_login").effect('shake');
    } else {
        $("#new_user").fadeOut(fadeTime);
        $("#top_button")
            .text(data.username)
            .css('background-color', 'white')
            .css('color', '#3867be')
            .on('click', function() {
            window.location.href='/users/' + data.id;
        });
    }
    checkFavorites();
}

function validateElementLength($el, len, type) {
    var id = $el.attr("id");
    var $label = $("label[for="+id+"]");
    if ($el.val().length < len) {
        $el.css('background-color', '#ea777a');
        $label.text(type + ' must be at least '+len+' characters...');
        return false;
    } else {
        $el.css('background-color', 'white');
        $label.text(type);
        return true;
    }
}

function validatePasswordsMatch() {
    var $p1 = $("#signup_password")
    var $p2 = $("#confirm_password")
    if ($p1.val() === $p2.val()) {
        $p2.css('background-color', 'white')
        return true;
    } else {
        $p2.css('background-color', '#ea777a')
        return false;
    }
}

function keyupValidations() {
    $("#confirm_password").on('keyup', function() {
        validatePasswordsMatch();
    });
    $("#signup_username").on('keyup', function() {
        validateElementLength($(this), 5, 'Email');
    });
    $("#signup_password").on('keyup', function() {
        validateElementLength($(this), 1, 'Password');
    });
}

function expandSignup() {
    $(".signup_button").on('click', function(){
        $("#signup_form").fadeIn(fadeTime);
    });
}

function clickSignup() {
    $("#signup_submit").on('click', function(e) {
        e.preventDefault();
        var validEmail = validateElementLength($("#signup_username"), 5, 'Email');
        var validPassword = validateElementLength($("#signup_password"), 1, 'Password');
        validatePasswordsMatch();
        keyupValidations();
        if (validEmail && validPassword && validatePasswordsMatch()) {
            submitSignup();
        }
    });
}
function cancelSignup() {
    $("#signup_cancel").on('click', function(e) {
        e.preventDefault();
        $("#signup_form").fadeOut(fadeTime);
    });
}

function submitSignup() {
    $.ajax({
        url: '/users',
        method: 'POST',
        dataType: 'json',
        data: {
            username: $("#signup_username").val(),
            password: $("#signup_password").val()
        },
        success: function(data) {
            $("#signup_form").fadeOut(fadeTime);
            loginSuccess(data);
        }
    });
}



// ****** search form *******

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
    $("#origin").on('keyup', function(){validateOrigin($(this).val());});
}

function validateDestination(value) {
    if ($.inArray(value, destinations) > -1) {
      // $("#origin_label").fadeIn(200);
      $("#destination_error").fadeOut(fadeTime);
      $("#origin").fadeIn(fadeTime);
    }
}

function validateOrigin(value) {
    if ($.inArray(value, origins) > -1) {
      $("#origin_error").fadeOut(fadeTime);
      showMonthandGo();      
    } 
}

function showMonthandGo() {
    $("#month_label").fadeIn(fadeTime);
    $("#month").fadeIn(fadeTime);
    $(".go").fadeIn(fadeTime);
    setInterval(function() { validateAll(); },1000) 
}

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
}

// *********  flickr images **********

function cycleImages(){
    $('#cycle-photos').cycle({
        fx: 'fade',
        speed: 1200,
        timeout:  3500 
    });
};

// *********  favorites scripts **********



function determineFavoritesButton(status) {
    console.log('determine button');
    $("#add-button").hide();
    $("#delete-button").hide();
    if (status === "false") {
        $("#add-button").show()
    } else {
        $("#delete-button").show()
    }
}

function checkFavorites() {
    console.log('check favorites (╯°□°)╯︵ ┻━┻');
    var url = document.URL;
    $.ajax({
        method: 'patch',
        url: '/check_favorites',
        dataType: 'json',
        data: { url: url },
        success: function(data) {
            determineFavoritesButton(data.status);
        }
    });
}

function addtoFavorites() {
    console.log('add to favorites');
    $("#add-button").on('click', function(e) {
      e.preventDefault();
      $.ajax({
          method: 'patch',
          url: '/add_favorites',
          dataType: 'json',
          data: { favorite: document.URL },
          success: function() {
            console.log('yay');
            checkFavorites();
        }
    });
  });
}


function deletefromFavorites(){
    console.log('delete from favorites');
    $("#delete-button").on('click', function(e){
        e.preventDefault();
        $.ajax({
            method: 'patch',
            url: '/delete_favorites',
            dataType: 'json',
            data: { remove: document.URL },
            success: function() {
              console.log('yay-removing!');
              checkFavorites();
            }
        });
    });
}
  
// ******* jCarousel functions ********
function jCarousel() { 
    var jcarousel = $('.jcarousel');

    jcarousel
    .on('jcarousel:reload jcarousel:create', function () {
        var width = jcarousel.innerWidth();

        if (width >= 1000) {
            width = width / 3;
        } else if (width >= 770) {
            width = width / 2;
        } else {
            width = width;
        }

        jcarousel.jcarousel('items').css('width', width + 'px');
    })
    .jcarousel({
        wrap: 'circular'
    });

    $('.jcarousel-control-prev')
    .jcarouselControl({
        target: '-=1'
    });

    $('.jcarousel-control-next')
    .jcarouselControl({
        target: '+=1'
    });

    $('.jcarousel-pagination')
    .on('jcarouselpagination:active', 'a', function() {
        $(this).addClass('active');
    })
    .on('jcarouselpagination:inactive', 'a', function() {
        $(this).removeClass('active');
    })
    .on('click', function(e) {
        e.preventDefault();
    })
    .jcarouselPagination({
        perPage: 1,
        item: function(page) {
            return '<a href="#' + page + '">' + page + '</a>';
        }
    });
}

// ******* document ready functions ********

function loadSearchPage() {
    fetchData();
    inputListener();
    $("input:submit.go").prop( "disabled", true );
    validateDestination();
    validateOrigin();
    changeBackground();
};

function loadLogin() {
    console.log('<^-_-^>')
    checkUser();
    ajaxLogin();
    expandLogin();
    clickSignup();
    cancelSignup();
};

