// load scriptures into a div with a class of 'oyb'
$(document).ready(function(){
  loadScripture();
  // function for updating verses to a specific day
  $('body').on("click", ".oyb-update", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    $.get("http://localhost:3000/get_passages", {day: $(this).attr("data-id"), version: $("#version").val()}, function(data){ $(".oyb").html(data); });
  });
  // version switcher
  $("body").on("change", ".oyb-version-switcher", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    $.get("http://localhost:3000/get_passages", {day: $("#current_day").val(), version: $(this).val()}, function(data){ $(".oyb").html(data); });
  });
});

// the function that loads the data from the server
function loadScripture() {
  $.get("http://localhost:3000/get_passages", function(data){ $(".oyb").html(data); });
}

// do stuff for the nav
$("body").on("click", ".oyb-nav-switcher", function(event){
  event.preventDefault();
  $(".oyb-passage").hide();
  $(".oyb-nav-switcher").removeClass("active");
  $("#" + $(this).attr("id") + "-passage").show();
  $(this).addClass("active");
});

