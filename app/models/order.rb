class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping_cost
  has_many :order_items

  def sum_item_price
    sum = 0
    order_items.select("price,quantity").each do |item|
      sum += (item.price * item.quantity)
    end
    sum
  end

end
