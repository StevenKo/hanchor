class ProductsController < ApplicationController
  before_action :get_cart_items

  def index
    @base_category = ProductCategory.find_by(name_en: params[:category])
    select_ids = @base_category.child_category_ids << [@base_category.id]

    @sub_category = ProductCategory.find_by(name_en: params[:sub]) if params[:sub]
    if params[:sub]
      @products = Product.includes(:product_infos).where("product_category_id = #{@sub_category.id}").paginate(:page => params[:page], :per_page => 9)
    else
      @products = Product.includes(:product_infos).where(product_category_id: select_ids).paginate(:page => params[:page], :per_page => 9)
    end
  end

  def show
    @base_category = ProductCategory.find_by name_en: params[:category]
    @product = Product.includes(:product_infos).select_info.find(params[:id])
    @sub_category = @product.product_category
    @item = CartItem.new
  end

end
