import 'chosen-js';

document.addEventListener('turbolinks:load', () => {
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '80vw'
  });
});
