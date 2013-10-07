class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_pic
  belongs_to :product_size
  belongs_to :product_color
  belongs_to :cart

  validates_presence_of :quantity, :product_id
end
