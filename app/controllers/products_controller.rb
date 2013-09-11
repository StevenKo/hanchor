class ProductsController < ApplicationController

  def index
    category = ProductCategory.find_by name_en: params[:category]
    @products = Product.joins(:product_infos).where("product_category_id = #{category.id}").limit(2).select_info
  end

  def show
    @product = Product.joins(:product_infos).select_info.find(params[:id])
  end

end
