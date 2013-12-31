class Admin::ProductSizesController < Admin::AdminController

  def index
    @product = Product.find_by_slug(params[:product_id])
    @sizes = @product.product_sizes
  end

  def destroy
    ProductSize.delete(params[:id])
    ProductQuantity.delete_size_quantity(params[:id])
    ProductQuantity.create_quantiy(params[:product_id])
    flash[:notice] = "delete success"
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

  def create_update
    params[:sizes][:product_size].each do |key,param|
      if ProductSize.exists?(key)
        size = ProductSize.find(key)
        size.update(param)
      else
        size = ProductSize.new(param)
        size.product_id = params[:product_id]
        size.save
      end
    end
    ProductQuantity.create_quantiy(params[:product_id])
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

end
