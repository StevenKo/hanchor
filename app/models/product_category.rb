class ProductCategory < ActiveRecord::Base
  has_many :products

  belongs_to :parent_category, foreign_key: 'parent_id', class_name: 'ProductCategory'
  has_many :child_categories, foreign_key: 'parent_id', class_name: 'ProductCategory'

  def self.generate_parent_select_category_array
    str_array = []
    str_array << ["無",""]
    all.each do |cat|
      str_array << ["#{cat.name}(#{cat.name_en})", cat.id] if cat.parent_id.nil?
    end
    str_array
  end


  def self.generate_category_array
    str_array = []
    all.each do |cat|
      str_array << [(cat.cateory_name_with_parent ""), cat.id]
    end
    str_array
  end

  def cateory_name_with_parent str

    if parent_category
      parent_category.cateory_name_with_parent "/"+ name
    else
      name + str
    end

  end
end
