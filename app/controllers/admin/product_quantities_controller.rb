class Admin::ProductQuantitiesController < Admin::AdminController

  def index
    @product = Product.find_by_slug(params[:product_id])
    @quantities = @product.product_quantities
  end

  def create
    params[:quantites][:product_quantity].each do |key,param|
      if ProductQuantity.exists?(key)
        quantity = ProductQuantity.find(key)
        quantity.update(param)
      end
    end
    redirect_to admin_product_product_quantities_path(params[:product_id])
  end

end
