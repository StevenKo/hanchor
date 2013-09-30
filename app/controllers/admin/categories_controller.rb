class Admin::CategoriesController < Admin::AdminController

  def index
    @categories = ProductCategory.all
  end

  def edit
    @category_selection = ProductCategory.generate_parent_select_category_array
    @category = ProductCategory.find(params[:id])
  end

  def new
    @category = ProductCategory.new
    @category_selection = ProductCategory.generate_parent_select_category_array
  end

  def create
    @category = ProductCategory.new(category_param)
    if @category.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to admin_categories_path
  end

  def update
    @category = ProductCategory.find(params[:id])
    if @category.update(category_param)
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_category_path(@category)
  end

  def destroy
    ProductCategory.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_categories_path
  end

private
  def category_param
    params.require(:product_category).permit(:parent_id,:name,:name_en,:sort,:is_visible)
  end

end
