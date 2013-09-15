$(document).ready(function() {
  $('#cart_item_quantity').change(function ()
  {
      $(this).closest('form').submit();
  });
});