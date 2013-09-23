class ProductColor < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :color,:color_en
end
