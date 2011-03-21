// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

(function() {
  MSG_MAXLENGTH = 140

  document.on('keyup', 'textarea.countdownable', function(event, element) {
    remaining_chars = MSG_MAX_LENGTH - event.findElement().getValue().length;
    $$('.countdown')[0].update(remaining_chars);
  })
})();
