class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :product_size
  belongs_to :product_color

  def display_name(country_id, locale)
    item_name = product.product_infos.where("product_infos.country_id = #{country_id}")[0].name
    item_color = product_color.locale_color(locale) if product_color
    item_size = product_size.locale_size(locale) if product_size
    if item_name && item_color && item_size
      "#{item_name}(#{item_color}/#{item_size})"
    elsif item_name && item_color
      "#{item_name}(#{item_color})"
    elsif item_name && item_size
      "#{item_name}(#{item_size})"
    else
      item_name
    end
  end
end
