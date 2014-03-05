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
      :currency_code => currency_code(locale),
      :notify_url => notify_url,
      :charset => 'utf-8'
    }
    cart_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => locale_price(item.price,locale),
        "item_name_#{index+1}" => item.product.product_infos.first.name,
        "quantity_#{index+1}" => item.quantity
      })
    end
    values.merge!({
      "amount_#{cart_items.size+1}" => locale_price(shipping_cost.cost,locale),
      "item_name_#{cart_items.size+1}" => shipping_cost.description,
      "quantity_#{cart_items.size+1}" => 1
    })
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def currency_code(locale)
    (locale=="en")? "USD" : "TWD"
  end

  def locale_price(amount,locale)
    (locale=="en")? (amount/28.0).round(2) : amount
  end

end
