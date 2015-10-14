$(document).ready(function() {

  var newPost = function() {
    event.preventDefault();
    var url = $(this).attr('href')
    $.ajax ({
      type: "GET",
      url: url
    })
    .done(function(response) {
      // console.log(response)
      $('#sidebar').html(response)
    })
  }

  $('#new_post_link').click(newPost)

  var prependPost = function(event){
    event.preventDefault();
    var url = $(this).attr('action');
    // console.log(url)
    var data = $('#post_form').serialize()
    $.ajax({
      type: 'POST',
      url: url,
      data: data
    })
    .done(function(response) {
      // console.log(response)
      $('#posts').prepend(response)
    })
  }

  $('#sidebar').on('submit', '#post_form', prependPost)
})
