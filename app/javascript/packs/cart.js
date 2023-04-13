$(document).ready(function () {
  const checkTablesForEmptyHeaders = () => {
    const tables = document.querySelectorAll('table');
    tables.forEach(table => {
      const tbody = table.querySelector('tbody');
      if (tbody.children.length === 0) {
        let elementId = table.getAttribute("id")
        if(elementId== 'product-table'){
          tbody.innerHTML = '<tr class = "no-entry-found text-center"><td colspan="999">No More Products on this page</td></tr>';
        }
        else if(elementId == 'cart-table'){
          tbody.innerHTML = '<tr class = "no-entry-found text-center"><td colspan="999">Cart does not have any product</td></tr>';
        }else{
          tbody.innerHTML = '<tr class = "no-entry-found text-center"><td colspan="999">No Entry Found</td></tr>';
        }
        
      }
    });
  }
  if ($(".cart-table")[0]) {
    $(document).on('change', 'input[type="number"]', function () {
      let id = $(this).attr('id').split('-')[1]
      let product_price = "product-price-" + id
      product_price = document.getElementById(product_price)
      let price_field = "total-price-" + id
      price_field = document.getElementById(price_field)
      const productField = document.getElementById("field-" + id);
      const productValue = productField.value;
      price_field.innerHTML = parseInt(productValue) * parseInt(product_price.innerHTML)
      updatePrice();
    });
  }
  $(document).on('click', '.remove-from-cart-button', function (event) {
    event.preventDefault();
    var product_id = $(this).data('product-id');
    var quantity = 1;
    let tr = $(this).closest("tr")
    $.ajax({
      url: '/products/' + product_id +'/remove_from_cart/',
      method: 'DELETE',
      data: {
        product_id: product_id,
        quantity: quantity
      },
      success: function (data) {
        tr.remove()
        $('#product-table tbody').append(data)
        updatePrice();
        checkTablesForEmptyHeaders();
        checkEmptyTable("#product-table");
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.log('Error:', errorThrown);
      }
    });
  });

  $(document).on('click', '.add-to-cart-button', function (event) {
    event.preventDefault();
    var product_id = $(this).data('product-id');
    let tr = $(this).closest("tr")
    $.ajax({
      url: '/products/' + product_id +'/add_to_cart',
      method: 'POST',
      data: {
        product_id: product_id
      },
      success: function (data) {
        tr.remove()
        $('.cart-table tbody').append(data)
        updatePrice();
        checkTablesForEmptyHeaders();
        checkEmptyTable(".cart-table");
      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.log('Error:', errorThrown);
      }
    });
  });


  const updatePrice = () => {
    const totalPriceField = document.getElementById('total-price');
    let totalPriceSum = 0;
    const totalPrices = document.querySelectorAll('[id^="total-price-"]');
    console.log(totalPrices)
    totalPrices.forEach(totalPrice => {
      totalPriceSum += parseFloat(totalPrice.textContent);
    });
    totalPriceField.innerHTML = `Total Price: ${totalPriceSum}`;
  }

  const checkEmptyTable = (selector) => {
    var table = $(selector)
    var rowsToRemove = table.find("tr.no-entry-found");
    rowsToRemove.remove();
  }
  checkTablesForEmptyHeaders();
});