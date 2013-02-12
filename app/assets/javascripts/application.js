// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui-1.10.0.custom.js
//= require jquery_ujs
//= require bootstrap.min.js
//= require jquery.tooltipster.min.js

$(document).ready(function() {
  addToolTipToCart();
});

function addToolTipToCart(){
  $('#cart a:first').tooltipster(
    {
      trigger: 'click',
      functionBefore: function(origin, continueTooltip) {
        origin.data('tooltipsterContent', $('#hidden-cart').html());
        continueTooltip();
      },
      functionAfter:  function(origin) {
        console.log("function after");
      },
      theme: '.tooltipster-light',
      interactive: true
    });
}
