class Admin::ProductSizesController < Admin::AdminController

  def index
    @product = Product.find_by_slug(params[:product_id])
    @sizes = @product.product_sizes.where("is_delete != true")
  end

  def destroy
    size = ProductSize.find(params[:id])
    size.is_delete = true
    size.save

    ProductQuantity.delete_size_quantity(params[:id])
    product = Product.find_by(slug: params[:product_id])
    ProductQuantity.create_quantiy(product.id)
    flash[:notice] = "delete success"
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

  def create_update
    product = Product.find_by(slug: params[:product_id])
    if params[:sizes]
      params[:sizes][:product_size].each do |key,param|
        if ProductSize.exists?(key)
          size = ProductSize.find(key)
          size.update(param)
        else
          size = ProductSize.new(param)
          size.product_id = product.id
          size.save
        end
      end
      ProductQuantity.create_quantiy(product.id)
    end
    redirect_to admin_product_product_sizes_path(params[:product_id])
  end

end
