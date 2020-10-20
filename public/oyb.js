var script = $('script[src*=oyb-dev]');
var token = script.attr('data-token');

// load scriptures into a div with a class of 'oyb'
$(document).ready(function(){
  loadScripture();
  // function for updating verses to a specific day
  $('body').on("click", ".oyb-update", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    $.get("https://oybplugin.com/get_passages", {day: $(this).attr("data-id"), token: token}, function(data){ $(".oyb").html(data); });
  });
});

// the function that loads the data from the server
function loadScripture() {
  $.get("https://oybplugin.com/get_passages", {token: token}, function(data){ $(".oyb").html(data); });
}

// do stuff for the nav
$("body").on("click", ".oyb-nav-switcher", function(event){
  event.preventDefault();
  $(".oyb-passage").hide();
  $(".oyb-nav-switcher").removeClass("active");
  $("#" + $(this).attr("id") + "-passage").show();
  $(this).addClass("active");
});

$("body").on("change", ".oyb-version-switcher", function(event){
  event.preventDefault();
  var bible = $(this).val();
  $.get("https://oybplugin.com/get_passages", {day: day, bible: bible, token: token}, function(data){ $(".oyb").html(data); });
});


