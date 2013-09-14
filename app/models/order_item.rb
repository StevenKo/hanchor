class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :product_size
  belongs_to :product_color
end
