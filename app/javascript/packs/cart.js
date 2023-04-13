$( document ).on('turbolinks:load', function() {
  function updatePrice() {
    const totalPriceField = $('#total-price');
    let totalPriceSum = 0;
    $('[id^="total-price-"]').each(function() {
      totalPriceSum += parseFloat($(this).text());
    });
    totalPriceField.html(`Total Price: ${totalPriceSum}`);
  }

  function checkEmptyTable(selector) {
    const table = $(selector);
    const rowsToRemove = table.find('tr.no-entry-found');
    rowsToRemove.remove();
  }

  function checkTablesForEmptyHeaders() {
    $('table').each(function() {
      const tbody = $(this).find('tbody');
      if (tbody.children().length === 0) {
        const elementId = $(this).attr('id');
        let noEntryText = '';
        if (elementId == 'product-table') {
          noEntryText = 'No More Products on this page';
        } else if (elementId == 'cart-table') {
          noEntryText = 'Cart does not have any product';
        } else {
          noEntryText = 'No Entry Found';
        }
        tbody.append(`<tr class="no-entry-found text-center"><td colspan="999">${noEntryText}</td></tr>`);
      }
    });
  }

  if ($('.cart-table')[0]) {
    $(document).on('change', 'input[type="number"]', function() {
      const id = $(this).attr('id').split('-')[1];
      let productPrice = 'product-price-' + id;
      productPrice = $(`#${productPrice}`);
      let priceField = 'total-price-' + id;
      priceField = $(`#${priceField}`);
      const productField = $(`#field-${id}`);
      const productValue = productField.val();
      priceField.text(parseInt(productValue) * parseInt(productPrice.text()));
      updatePrice();
    });
    
    $(document).on('click', '.remove-from-cart-button', function(event) {
      event.preventDefault();
      const productId = $(this).data('product-id');
      const quantity = 1;
      const tr = $(this).closest('tr');
      $.ajax({
        url: `/products/${productId}/remove_from_cart/`,
        method: 'DELETE',
        data: {
          product_id: productId,
          quantity: quantity
        },
        success: function(data) {
          tr.remove();
          $('#product-table tbody').append(data);
          updatePrice();
          checkTablesForEmptyHeaders();
          checkEmptyTable('#product-table');
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', errorThrown);
        }
      });
    });
    
    $(document).on('click', '.add-to-cart-button', function(event) {
      event.preventDefault();
      const productId = $(this).data('product-id');
      const tr = $(this).closest('tr');
      $.ajax({
        url: `/products/${productId}/add_to_cart`,
        method: 'POST',
        data: {
          product_id: productId
        },
        success: function(data) {
          tr.remove();
          $('.cart-table tbody').append(data);
          updatePrice();
          checkTablesForEmptyHeaders();
          checkEmptyTable('.cart-table');
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log('Error:', errorThrown);
        }
      });
    });
  }
    
  checkTablesForEmptyHeaders();

  $(document).on('turbolinks:before-cache', function() {
    $(document).off('change', 'input[type="number"]');
    $(document).off('click', '.add-to-cart-button');
  });
});
