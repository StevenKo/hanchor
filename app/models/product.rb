class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_colors
  has_many :product_pics
  has_many :product_sizes
  has_many :product_quantities
  has_many :product_infos
end
