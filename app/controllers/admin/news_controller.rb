class Admin::NewsController < Admin::AdminController

  def index
    @news = News.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    @news = News.new(news_param)
    if @news.save
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_news_path(@news)
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_param)
      flash[:notice] = "Update success"
    else
      flash[:error] = "Update fail!"
    end
    redirect_to edit_admin_news_path(@news)
  end

  def destroy
    News.delete(params[:id])
    flash[:notice] = "delete success"
    redirect_to admin_news_index_path
  end

private
  def news_param
    params.require(:news).permit(:title,:content,:pic,:sort,:sort_en,:is_tw,:is_en)
  end

end
