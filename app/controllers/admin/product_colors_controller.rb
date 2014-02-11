class Admin::ProductColorsController < Admin::AdminController

  def index
    @product = Product.find_by_slug(params[:product_id])
    @colors = @product.product_colors.where("is_delete != true")
  end

  def destroy
    color = ProductColor.find(params[:id])
    color.is_delete = true
    color.save

    flash[:notice] = "delete success"
    ProductQuantity.delete_color_quantity(params[:id])
    product = Product.find_by(slug: params[:product_id])
    ProductQuantity.create_quantiy(product.id)
    redirect_to admin_product_product_colors_path(params[:product_id])
  end

  def create_update
    product = Product.find_by(slug: params[:product_id])
    if params[:colors]
      params[:colors][:product_color].each do |key,param|
        if ProductColor.exists?(key)
          product_color = ProductColor.find(key)
          product_color.update(param)
        else
          color = ProductColor.new(param)
          color.product_id = product.id
          color.save
        end
      end
      ProductQuantity.create_quantiy(product.id)
    end
    redirect_to admin_product_product_colors_path(params[:product_id])
  end

end
