class Product < ActiveRecord::Base
  belongs_to :product_category
  has_many :product_colors
  has_many :product_pics, -> {order :sort}
  has_one :thumb, -> {order :sort}, :class_name => 'ProductPic', :foreign_key => "product_id"
  has_many :product_sizes
  has_many :product_quantities
  has_many :product_infos

  scope :visible, -> {where("product_infos.is_visible = true")}

  scope :select_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.special_price,
                                    product_infos.quick_overview, 
                                    products.id,
                                    product_category_id,
                                    products.slug"
                        ) }

  scope :all_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.special_price,
                                    product_infos.quick_overview,
                                    product_infos.weight,
                                    product_infos.capacity,
                                    product_infos.material,
                                    product_infos.feature,
                                    products.views,
                                    products.id,
                                    product_category_id,
                                    products.slug"
                        ) }
  scope :cart_info, -> { select(" product_infos.name,
                                    product_infos.price,
                                    product_infos.shipping,
                                    products.id,
                                    product_category_id,
                                    products.slug"
                        ) }
  scope :admin_index_info, -> { select("products.id,
                                        no,
                                        product_category_id,
                                        product_infos.name,
                                        product_infos.price,
                                        product_infos.special_price,
                                        products.sort,
                                        products.views,
                                        product_infos.is_visible,
                                        products.slug"
                              )}
  scope :order_by_views_and_sort, -> { order("sort desc,views desc")}

  def to_param
    slug
  end

  def reorder_pic_sort
    product_pics.each_with_index do |pic, index|
      pic.update_attribute(:sort,index+1)
    end
  end

  def size_selector locale
    if ["zh-TW","zh"].include?( locale )
      product_sizes.not_deleted.map{|size| [size.size,size.id]}
    else
      product_sizes.not_deleted.map{|size| [size.size_en,size.id]}
    end
  end

  def color_selector locale
    if ["zh-TW","zh"].include?( locale )
      product_colors.not_deleted.map{|color| [color.color,color.id]}
    else
      product_colors.not_deleted.map{|color| [color.color_en,color.id]}
    end
  end

  def sum_quantities
    product_quantities.map(&:quantity).inject(:+)
  end

end
