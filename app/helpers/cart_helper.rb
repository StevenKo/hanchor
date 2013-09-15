module CartHelper
  def sum_cart_items_price items
    sum = 0
    items.each do |item|
      sum += (item.price * item.quantity)
    end
    sum
  end
end