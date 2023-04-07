$(document).ready(function () {
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
    });
  }
  $(document).on('click', '.remove-from-cart-button', function (event) {
    event.preventDefault();
    var product_id = $(this).data('product-id');
    var quantity = 1;
    let tr = $(this).closest("tr")
    $.ajax({
      url: '/products/remove_from_cart/' + product_id,
      method: 'DELETE',
      data: {
        product_id: product_id,
        quantity: quantity
      },
      // dataType: 'json',
      success: function (data) {
        console.log('data')
        tr.hide()
        $('#product-table tbody').append(data)

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
      url: '/products/add_to_cart/' + product_id,
      method: 'POST',
      data: {
        product_id: product_id
      },
      // dataType: 'json',
      success: function (data) {
        console.log('data')
        tr.hide()
        $('.cart-table tbody').append(data)

      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.log('Error:', errorThrown);
      }
    });
  });

  $(document).ready(function() {
    $('input[type="number"]').change(function() {
      let id = $(this).attr('id').split('-')[1]
      let product_price = "product-price-" + id
      product_price = document.getElementById(product_price)
      let price_field = "total-price-" + id
      price_field= document.getElementById(price_field)
      const productField = document.getElementById("field-2");
      const productValue = productField.value;
      price_field.innerHTML = parseInt(productValue) * parseInt(product_price.innerHTML)
    });
  });
  
});
