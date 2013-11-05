$ ->
  $('tr.hover.order').on 'click', (event) ->
    $(this).next().toggle();