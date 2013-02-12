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

  //Cart edition
  bindChangeQuantity();
});

function addToolTipToCart(){
  $('#cart a:first').tooltipster(
    {
      trigger: 'click',
      functionBefore: function(origin, continueTooltip) {
        origin.data('tooltipsterContent', $('#hidden-cart').html());
        continueTooltip();
      },
      theme: '.tooltipster-light',
      interactive: true
    });
}

function bindChangeQuantity(){
  if ($('table#cart-edition').length > 0){
    $("li#cart").hide();
  }

  $('table#cart-edition tr.item-data td input[type=number].quantity')
    .each(function(index, element){
      $(element).change(function(){
        calculateTotal();
      })
    })
}


function calculateTotal(tr){
  var amount = 0;
  var items = 0;

  $('table#cart-edition tr.item-data')
    .each(function(index, element){
      var quantity  = 0;
      var unitPrice = 0.0;
      var subtotal  = 0.0;

      quantity  = parseInt($(element).find('input[type=number].quantity').val());
      unitPrice = parseFloat($(element).find('td.price').text());
      console.log(unitPrice);
      subtotal  = quantity * unitPrice;

      $(element).find('td.subtotal').text(parseFloat(Math.round(subtotal * 100) / 100).toFixed(2));

      items  += quantity;
      amount += subtotal;
    });

    amount = parseFloat(Math.round(amount * 100) / 100).toFixed(2);
  $('td#items-total').fadeOut(500, function() {
      $(this).text(items).fadeIn(500);
  });

  $('td#amount-total').fadeOut(500, function() {
      $(this).text("$ " + amount).fadeIn(500);
  });
}