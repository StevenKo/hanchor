class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping_cost
  has_many :order_items

end
