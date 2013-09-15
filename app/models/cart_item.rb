class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_pic
  belongs_to :product_size
  belongs_to :product_color
  belongs_to :cart
end
