$(document).on('turbolinks:load', function() {
    $( "#submission-content" ).on( "click", "button", function(e) {
        var content = $("#submission-content textarea").val();
        var exerciseId = $("#submission-content #exercise_id").val();
        var url = "/admin/exercises/" + exerciseId + "/submissions";
        $('#progress-spinner').addClass('bar');
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
          $('#progress-spinner').removeClass('bar');
        });
        request.fail(function( jqXHR, textStatus, errorThrown) {
          $('#progress-spinner').removeClass('bar');
        });
    });

    $("textarea").keydown(function(e) {
        if(e.keyCode === 9) { // tab was pressed
            // get caret position/selection
            var start = this.selectionStart;
            var end = this.selectionEnd;
            var spaces = "    "
            var $this = $(this);
            var value = $this.val();
            // set textarea value to: text before caret + tab + text after caret
            $this.val(value.substring(0, start)
                        + spaces
                        + value.substring(end));
            // put caret at right position again (add one for the tab)
            this.selectionStart = this.selectionEnd = start + spaces.length;
            // prevent the focus lose
            e.preventDefault();
        }
    });
});

