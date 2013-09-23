class ProductQuantity < ActiveRecord::Base
  belongs_to :product
  belongs_to :product_color
  belongs_to :product_size


  def self.create_quantiy product_id
    colors = ProductColor.where("product_id = #{product_id}")
    sizes = ProductSize.where("product_id = #{product_id}")
    colors.each do |color|
      sizes.each do |size|
        quantity = ProductQuantity.where("product_color_id = #{color.id} and product_size_id = #{size.id}").first
        ProductQuantity.create(product_id: product_id, product_color_id: color.id, product_size_id: size.id) if quantity.blank?
        ProductQuantity.delete_all("product_id = #{product_id} and (product_color_id is null or product_color_id is null) ")
      end
    end

    if colors.blank?
      sizes.each do |size|
        quantity = ProductQuantity.where("product_size_id = #{size.id}").first
        ProductQuantity.create(product_id: product_id, product_size_id: size.id) if quantity.blank?
      end
    end

    if sizes.blank?
      colors.each do |color|
        quantity = ProductQuantity.where("product_color_id = #{color.id}").first
        ProductQuantity.create(product_id: product_id, product_color_id: color.id) if quantity.blank?
      end
    end

  end

  def self.delete_color_quantity product_color_id
    ProductQuantity.delete_all("product_color_id = #{product_color_id}")
  end

  def self.delete_size_quantity product_size_id
    ProductQuantity.delete_all("product_size_id = #{product_size_id}")
  end

end
