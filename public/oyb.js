$(document).ready(function(){
  loadScripture();
  // function for updating verses to a specific day
  $('body').on("click", ".update", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    // $.get("http://oyb.herokuapp.com/get_passages?day=" + $(this).attr("data-id"), function(data){ $(".oyb").html(data); });
    $.get("http://localhost:3000/get_passages?cache=true&devotional=false&day=" + $(this).attr("data-id"), function(data){ $(".oyb").html(data); });
  });
});

// the function that loads the data from the server
function loadScripture() {
  $.get("http://oyb.herokuapp.com/get_passages?cache=true&devotional=false", function(data){ $(".oyb").html(data); });
}

