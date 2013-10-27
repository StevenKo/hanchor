class ProductsController < ApplicationController
  before_action :get_cart_items

  def index
    page_size = 9
    page_size = 100 if params[:all]

    @base_category = ProductCategory.find_by(name_en: params[:category])
    select_ids = @base_category.child_category_ids << [@base_category.id]

    @sub_category = ProductCategory.find_by(name_en: params[:sub]) if params[:sub]
    if params[:sub]
      @products = Product.includes(:thumb).joins(:product_infos).where("product_infos.country_id = #{@country_id} and product_category_id = #{@sub_category.id}").order_by_views_and_sort.select_info.paginate(:page => params[:page], :per_page => page_size)
    else
      @products = Product.includes(:thumb).joins(:product_infos).where("product_category_id in (#{select_ids.join(",")}) and product_infos.country_id = #{@country_id}").order_by_views_and_sort.select_info.paginate(:page => params[:page], :per_page => page_size)
    end
  end

  def show
    @base_category = ProductCategory.find_by name_en: params[:category]
    @product = Product.includes(:product_category,:product_pics).joins(:product_infos).where("product_infos.country_id = #{@country_id}").all_info.find(params[:id])
    @product.update_attribute("views",@product.views+1)
    @sub_category = @product.product_category
    @item = CartItem.new
    @product_size_selector = @product.size_selector(params[:locale])
    @product_color_selector = @product.color_selector(params[:locale])
  end

  def quantity
    @quantity = ProductQuantity.where(product_color_id: params[:color_id], product_size_id: params[:size_id])[0]
    @quantity_selector = @quantity.quantity_selector
  end

end
