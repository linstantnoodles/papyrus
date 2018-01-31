$(document).on('turbolinks:load', function() {
    $( "#submission-content" ).on( "click", "button", function(e) {
        var content = $("#submission-content textarea").val();
        var exerciseId = $("#submission-content #exercise_id").val();
        var url = "/admin/exercises/" + exerciseId + "/submissions";
        var request = $.ajax({
          url: url,
          method: "POST",
          data: {
            content: content,
            exercise_id:  exerciseId
          },
          dataType: "json"
        });
        request.done(function( msg ) {
          $("#test-results pre").html(msg.result);
        });
        request.fail(function( jqXHR, textStatus ) {
          console.log(textStatus);
        });
    });
});