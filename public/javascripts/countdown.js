// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//
(function() {
  function msg_countdown(event, elt) {
      elt.update( 140 - event.element().getValue().length );
  }

  function apply_countdown(watch_elt, display_elt) {
    watch_elt.observe('keyup', function(event) {
      msg_countdown(event, display_elt);
    });
  }

  //Tested this on jsbin: http://jsbin.com/ovobi3/4/edit

  document.observe("dom:loaded", function() {
    $$('.countdownable').each( function(item) { apply_countdown(item, $$('.countdown')[0])});
  });
})();
