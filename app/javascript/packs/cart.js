$(document).ready(function () {
	if ($(".cart-table")[0]) {
		$('input[type="number"]').change(function () {
			let id = $(this).attr('id').split('-')[1]
			let product_price = "product-price-" + id
			product_price = document.getElementById(product_price)
			let price_field = "total-price-" + id
			price_field = document.getElementById(price_field)
			const productField = document.getElementById("field-"+id);
			const productValue = productField.value;
			price_field.innerHTML = parseInt(productValue) * parseInt(product_price.innerHTML)
		});
	}
});