// Countdown for microposts showing how many characters are left.
// Moved functionality into application.js
(function() {
  MSG_MAXLENGTH = 140

  function apply_countdown(watch_elt, display_elt) {
    watch_elt.observe('keyup', function(event) {
      display_elt.update(MSG_MAXLENGTH - watch_elt.getValue().length );
    });
  }

  //Tested this on jsbin: http://jsbin.com/ovobi3/4/edit

  document.observe("dom:loaded", function() {
    $$('.countdovvwnable').each( function(item) { apply_countdown(item, $$('.countdown')[0])});
  });

  document.on('keyup', 'textarea.countdownable', function(event, element) {
    val = event.findElement().getValue()
    $$('.countdown')[0].update(MSG_MAXLENGTH - val.length );
  })
})();
