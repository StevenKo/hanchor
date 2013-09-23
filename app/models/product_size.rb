class ProductSize < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :size,:size_en
end
