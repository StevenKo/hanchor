class Admin::ProductsController < Admin::AdminController

  def index
    @products = Product.paginate(:page => params[:page], :per_page => 1)
  end

  def show
    @product = Product.find(params[:id])
    @category_selection = ProductCategory.generate_category_array
  end

end
