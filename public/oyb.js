// load scriptures into a div with a class of 'oyb'
$(document).ready(function(){
  loadScripture();
  // function for updating verses to a specific day
  $('body').on("click", ".oyb-update", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    $.get("https://oyb.prototyperobotics.com/get_passages?day=" + $(this).attr("data-id"), function(data){ $(".oyb").html(data); });
  });
});

// the function that loads the data from the server
function loadScripture() {
  $.get("https://oyb.prototyperobotics.com/get_passages", function(data){ $(".oyb").html(data); });
}

// do stuff for the nav
$("body").on("click", ".oyb-nav-switcher", function(event){
  event.preventDefault();
  $(".oyb-passage").hide();
  $(".oyb-nav-switcher").removeClass("active");
  $("#" + $(this).attr("id") + "-passage").show();
  $(this).addClass("active");
});

