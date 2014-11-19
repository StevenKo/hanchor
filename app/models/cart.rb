class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def paypal_url(return_url,locale,notify_url,order_id,shipping_cost)
    values = {
      :business => 'JQP4PTRJQ8KHY',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => order_id,
      :lc => locale,
      :currency_code => "TWD",
      :notify_url => notify_url,
      :charset => 'utf-8'
    }
    cart_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.product.product_infos.first.name,
        "quantity_#{index+1}" => item.quantity
      })
    end
    values.merge!({
      "amount_#{cart_items.size+1}" => shipping_cost.cost,
      "item_name_#{cart_items.size+1}" => shipping_cost.description,
      "quantity_#{cart_items.size+1}" => 1
    })
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
