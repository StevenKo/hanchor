class ProductInfo < ActiveRecord::Base
  belongs_to :product
  belongs_to :country

  serialize :shipping, Array
end
