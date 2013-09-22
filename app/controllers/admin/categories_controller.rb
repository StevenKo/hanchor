class Admin::CategoriesController < Admin::AdminController

  def index
    @categories = ProductCategory.all
  end

  def edit
    @category_selection = ProductCategory.generate_parent_select_category_array
    @category = ProductCategory.find(params[:id])
  end

end
