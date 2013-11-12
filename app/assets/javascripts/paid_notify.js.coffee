$ ->
  $('a#order_modal_link').on 'click', (event) ->
    $('#order_id').val($(this).data('order-id'))