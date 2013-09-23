class Admin::ProductSizesController < Admin::AdminController

  def index
    @product = Product.find(params[:product_id])
    @sizes = @product.product_sizes
  end

  def destroy
    ProductSize.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

  def create_update
    params[:colors][:product_size].each do |key,param|
      if ProductSize.exists?(key)
        size = ProductSize.find(key)
        size.update(param)
      else
        size = ProductSize.new(param)
        size.product_id = params[:product_id]
        size.save
      end
    end
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

end
