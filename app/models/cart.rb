class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items

  def paypal_url(return_url,locale,notify_url,order_id)
    values = {
      :business => 'chunyuko85-facilitator@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => order_id,
      :lc => locale,
      :currency_code => currency_code(locale),
      :notify_url => notify_url
    }
    cart_items.each_with_index do |item, index|
      values.merge!({
        "amount_#{index+1}" => locale_price(item.price,locale),
        "item_name_#{index+1}" => item.product.product_infos.first.name,
        "item_number_#{index+1}" => item.id,
        "quantity_#{index+1}" => item.quantity
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def currency_code(locale)
    (locale=="en")? "USD" : "TWD"
  end

  def locale_price(amount,locale)
    (locale=="en")? (amount/28.0).round : amount
  end

end
