class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def self.create_new_cart user_id
    if user_id
      Cart.create
    else
      Cart.create(user_id: user_id)
    end
  end

  def paypal_url(return_url)
    values = {
      :business => 'chunyuko85-facilitator@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => id
    }
    cart_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => item.price,
        "item_name_#{index+1}" => item.product.product_infos.first.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
