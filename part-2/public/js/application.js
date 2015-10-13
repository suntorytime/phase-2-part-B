$(document).ready(function() {
  $(".button_anchor").click(function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    // console.log(url)
    $.ajax({
      type: "get",
      url: url,
    }).done(function(response) {
      // console.log(response)
      $("#sidebar").append(response)
      $('#new_post_link').hide()
    })
  })

  $("#sidebar").on("submit", "#post_form", function(event) {
    // console.log("Hello")
    event.preventDefault();
    var url = $("#post_form").attr('action');
    console.log(url)
    $.ajax({
      type: "post",
      url: url,
      data: $("#post_form").serialize(),
      dataType: "json"
    }).done(function(response) {
      console.log(response)
      $("#posts").prepend(response)
    })
  })
})
