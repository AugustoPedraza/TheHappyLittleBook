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
  bindMakePurchase();
  bindRemoveBook();
});

function bindMakePurchase(){
  var $btn = $('#create-new-purchase');

  if ($btn.length == 0){return;}

  var url = $btn.attr('url-data');

  $btn.on('click', function(jsEvent){
    var jsonObj = [];

    $('table#cart-edition tr[item-id-data]').each(function(index, tr){
      var $tr  = $(tr);
      itemId   = parseInt($(tr).attr('item-id-data'));
      quantity = parseInt($tr.find('td input[type=number].quantity').val());

      var obj  = {"id": itemId, "quantity": quantity};
      jsonObj.push(obj);
    });

    updateCartRequest(url, jsonObj);
    return false;
  });
}


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

        var availableStock = parseInt($(this).parents('tr').attr('available-stock-data'));
        var enteredStock   = parseInt(this.value);

        if (enteredStock > availableStock){
          var bookName = $(this).parents('tr').find('td.book-name').text();
          showError('El stock disponible del libro <b>' + bookName + '</b> es de ' + availableStock +' unidades.');
          this.value  = availableStock;
        }

        calculateTotal();
      })
    })
}

function calculateTotal(){
  var amount = 0;
  var items = 0;

  $('table#cart-edition tr.item-data')
    .each(function(index, element){
      var quantity  = 0;
      var unitPrice = 0.0;
      var subtotal  = 0.0;

      quantity  = parseInt($(element).find('input[type=number].quantity').val());
      unitPrice = parseFloat($(element).find('td.price').text());
      subtotal  = quantity * unitPrice;

      $(element).find('td.subtotal').text(parseFloat(Math.round(subtotal * 100) / 100).toFixed(2));

      items  += quantity;
      amount += subtotal;
    });

    amount = parseFloat(Math.round(amount * 100) / 100).toFixed(2);

    updateTotals(items, amount);
}

function updateTotals(items, amount){
  if(items == 0){
    var url  = $('tr.cart-actions td input[type=submit].btn-make-purchase')
                  .attr('url-redirect-data');

    alert("El carrito está vacio!");
    window.location.href = url;
  }

  $('td#items-total').fadeOut(500, function() {
      $(this).text(items).fadeIn(500);
  });

  $('td#amount-total').fadeOut(500, function() {
      $(this).text("$ " + amount).fadeIn(500);
  });
}

function updateCartRequest(url, jsonObj){
  $.ajax({
    dataType: "json",
    cache:    false,
    url:      url,
    timeout:  2000,
    data:     {items: jsonObj},
    type:    'PUT',
    error:    function(XMLHttpRequest, errorTextStatus, error){
      alert("Failed to submit : "+ XMLHttpRequest + "\n" + errorTextStatus+" ;"+error);
    },
    success:  function(data){
      if(data["status"] === "redirect"){
        window.location.replace(data["to"]);
      }
    }
  });
}

function showError(message){
  var html = '<div class="alert alert-error"> \
                <button type="button" class="close" data-dismiss="alert">&times;</button> \
                <strong>Sin stock!</strong><br/>' + message +
             '</div>';

  $('table#cart-edition tr#alert-section td').html(html);

  window.setTimeout(function() {
    $("table#cart-edition tr#alert-section td .alert").fadeTo(1500, 0).slideUp(500, function(){
         $(this).remove();
    });
  }, 7000);
}

function bindRemoveBook(){
  $('a.remove-book').each(function(index, element){
    $(element).click(function(){
      $(this).parents('tr').remove();
      calculateTotal();
    });
  });
}