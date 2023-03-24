$(document).ready(function (e) {
	if ($(".flash")[0]) {
		$('.close-flash').on('click', function () {
			$('.flash').addClass('d-none')
		});
	}
});