class Admin::ProductsController < Admin::AdminController

  def index

    if(params[:parent_category] && params[:category])
      @categories = ProductCategory.where("id = #{params[:category]}").select("id, name, parent_id")
      categories_id = @categories.map(&:id).join(",")
      @products = Product.joins(:product_infos).admin_index_info.where("product_category_id in (#{categories_id}) and product_infos.country_id = 1").paginate(:page => params[:page], :per_page => 20)
    elsif(params[:category])
      @categories = ProductCategory.where("parent_id = #{params[:category]} or id = #{params[:category]}").select("id, name, parent_id")
      categories_id = @categories.map(&:id).join(",")
      @products = Product.joins(:product_infos).admin_index_info.where("product_category_id in (#{categories_id}) and product_infos.country_id = 1").paginate(:page => params[:page], :per_page => 20)
    else
      @categories = ProductCategory.where("parent_id is null").select("id, name, parent_id")
      @products = Product.joins(:product_infos).where("product_infos.country_id = 1").admin_index_info.paginate(:page => params[:page], :per_page => 20)
    end

  end

  def edit
    @product = Product.find_by_slug(params[:id])
    @category_selection = ProductCategory.generate_category_array
    @shipping_tw = ShippingCost.where(country_id: 1)
    @shipping_en = ShippingCost.where(country_id: 2)
  end

  def update
    @product = Product.find_by_slug(params[:id])
    begin
      Product.transaction do
        @product.update(product_param)
        info_tw = @product.product_infos[0]
        info_tw.shipping = params[:shipping][:tw] if params[:shipping]
        info_tw.update(product_info_tw)
        info_en = @product.product_infos[1]
        info_en.shipping = params[:shipping][:en] if params[:shipping]
        info_en.update(product_info_en)
        @product.save
      end
      flash[:notice] = "Update success"
    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_product_path(@product)
  end

  def new
    @product = Product.new
    @product.product_infos << ProductInfo.new
    @product.product_infos << ProductInfo.new
    @category_selection = ProductCategory.generate_category_array
    @shipping_tw = ShippingCost.where(country_id: 1)
    @shipping_en = ShippingCost.where(country_id: 2)
  end

  def create
    begin
      Product.transaction do
        @product = Product.create(product_param)
        @product.product_infos << ProductInfo.create(product_info_tw)
        @product.product_infos << ProductInfo.create(product_info_en)
        @product.slug = @product.product_infos[1].name.to_slug.to_s
        @product.slug = @product.id if @product.slug.blank?
        @product.save
      end
        flash[:notice] = "Create success"
    rescue ActiveRecord::RecordInvalid => invalid   
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_product_path(@product)
  end

  def destroy
    @product = Product.find_by_slug(params[:id])
    @product.delete
    flash[:notice] = "delete success"
    redirect_to admin_products_path
  end

private
  def product_param
    params.require(:product).permit(:product_category_id,:no, :sort, :is_show_at_index)
  end

  def product_info_tw
    params.require(:product).require(:product_info).require("0").permit(:name,:weight,:material,:capacity,:quick_overview,:price,:special_price,:feature,:views,:is_visible,:country_id)
  end

  def product_info_en
    params.require(:product).require(:product_info).require("1").permit(:name,:weight,:material,:capacity,:quick_overview,:price,:special_price,:feature,:views,:is_visible,:country_id)
  end

end
