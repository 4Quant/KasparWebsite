

$(() => {
  $('#dropdown-nav').on('shown.bs.collapse', () => {
    $('#dropdown-nav').on('click', () => {
      $('#dropdown-nav').collapse('hide');
    });
  });
  $('#dropdown-nav').on('hidden.bs.collapse', () => {
    $('#dropdown-nav').off('click');
  });
});
