class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_colors
  has_many :product_pics, -> {order :sort}
  has_one :thumb, -> {order :sort}, :class_name => 'ProductPic', :foreign_key => "product_id"
  has_many :product_sizes
  has_many :product_quantities
  has_many :product_infos

  scope :select_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.special_price,
                                    product_infos.quick_overview, 
                                    products.id,
                                    product_category_id"
                        ) }

  scope :all_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.special_price,
                                    product_infos.quick_overview,
                                    product_infos.weight,
                                    product_infos.capacity,
                                    product_infos.material,
                                    product_infos.feature,
                                    product_infos.views,
                                    products.id,
                                    product_category_id"
                        ) }
  scope :cart_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.shipping,
                                    products.id,
                                    product_category_id"
                        ) }
  scope :admin_index_info, -> { select("products.id,
                                        no,
                                        product_category_id,
                                        product_infos.name,
                                        product_infos.price,
                                        product_infos.special_price,
                                        product_infos.sort,
                                        product_infos.views,
                                        product_infos.is_visible"
                              )}
  scope :order_by_views_and_sort, -> { order("sort desc,views desc")}


  def reorder_pic_sort
    product_pics.each_with_index do |pic, index|
      pic.update_attribute(:sort,index+1)
    end
  end

  def size_selector locale
    if locale == "zh-TW"
      product_sizes.map{|size| [size.size,size.id]}
    else
      product_sizes.map{|size| [size.size_en,size.id]}
    end
  end

  def color_selector locale
    if locale == "zh-TW"
      product_colors.map{|color| [color.color,color.id]}
    else
      product_colors.map{|color| [color.color_en,color.id]}
    end
  end

  def sum_quantities
    product_quantities.map(&:quantity).inject(:+)
  end

end
