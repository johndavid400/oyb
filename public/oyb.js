$(document).ready(function(){
  loadScripture();
  // function for updating verses to a specific day
  $('body').on("click", ".update", function(event){
    event.preventDefault();
    $(".oyb").html("Loading...");
    $.get("http://localhost:3000/get_passages?day=" + $(this).attr("data-id"), function(data){ $(".oyb").html(data); });
  });
});

// the function that loads the data from the server
function loadScripture(divClass) {
  $.get("http://localhost:3000/get_passages", function(data){ $(".oyb").html(data); });
}

