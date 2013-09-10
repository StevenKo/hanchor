class ProductCategory < ActiveRecord::Base
  has_many :products

  belongs_to :parent_category, foreign_key: 'parent_id', class_name: 'ProductCategory'
  has_many :child_categories, foreign_key: 'parent_id', class_name: 'ProductCategory'
end
