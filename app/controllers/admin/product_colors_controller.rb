class Admin::ProductColorsController < Admin::AdminController

  def index
    @product = Product.find_by_slug(params[:product_id])
    @colors = @product.product_colors
  end

  def destroy
    ProductColor.delete(params[:id])
    flash[:notice] = "delete success"
    ProductQuantity.delete_color_quantity(params[:id])
    ProductQuantity.create_quantiy(params[:product_id])
    redirect_to admin_product_product_colors_path(params[:product_id])
  end

  def create_update
    params[:colors][:product_color].each do |key,param|
      if ProductColor.exists?(key)
        product = ProductColor.find(key)
        product.update(param)
      else
        color = ProductColor.new(param)
        color.product_id = params[:product_id]
        color.save
      end
    end
    ProductQuantity.create_quantiy(params[:product_id])
    redirect_to admin_product_product_colors_path(params[:product_id])
  end

end
