module CartHelper
  
  def sum_cart_items_price items
    sum = 0
    items.each do |item|
      sum += (item.price * item.quantity)
    end
    sum
  end

  def get_cart_item_quantity_selector(item)
    ProductQuantity.where(product_color_id: item.product_color_id, product_size_id: item.product_size_id)[0].quantity_selector
  end
end