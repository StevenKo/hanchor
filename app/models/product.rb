class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_colors
  has_many :product_pics
  has_many :product_sizes
  has_many :product_quantities
  has_many :product_infos

  scope :select_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.feature,
                                    product_infos.quick_overview, 
                                    products.id,
                                    product_category_id"
                        ) }
end
