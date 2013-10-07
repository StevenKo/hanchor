$ ->
  $("#cart_item_product_color_id,#cart_item_product_size_id").change ->
    color_id = $("#cart_item_product_color_id :selected").val()
    size_id = $("#cart_item_product_size_id :selected").val()
    $.ajax
      url: "/products/quantity"
      type: "get"
      data:
        color_id: color_id
        size_id: size_id
  $( "#cart_item_product_color_id" ).change();
      

