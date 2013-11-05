class Admin::NewsTagsController < Admin::AdminController

  def index
    @tags = NewsTag.all
  end

  def edit
    @tag = NewsTag.find(params[:id])
  end

  def new
    @tag = NewsTag.new
  end

  def update
    @tag = NewsTag.find(params[:id])
    if @tag.update(tag_param)
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_news_tag_path(@tag)
  end

  def create
    @tag = NewsTag.new(tag_param)
    if @tag.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_news_tag_path(@tag)
  end

  def destroy
    NewsTag.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_news_tags_path
  end

private
  def tag_param
    params.require(:news_tag).permit(:name,:name_en)
  end
end