class ProductsController < ApplicationController
  before_action :get_cart_items

  def index
    @base_category = ProductCategory.find_by name_en: params[:category]
    @sub_category = ProductCategory.find_by(name_en: params[:sub]) if params[:sub]
    if params[:sub]
      @products = Product.joins(:product_infos).where("product_category_id = #{@sub_category.id}").limit(2).select_info
    else
      @products = Product.joins(:product_infos).where("product_category_id = #{@base_category.id}").limit(2).select_info
    end
  end

  def show
    @base_category = ProductCategory.find_by name_en: params[:category]
    @product = Product.joins(:product_infos).select_info.find(params[:id])
    @sub_category = @product.product_category
    @item = CartItem.new
  end

end
