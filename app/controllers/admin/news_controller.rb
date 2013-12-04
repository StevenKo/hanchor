class Admin::NewsController < Admin::AdminController

  def index
    @news = News.paginate(:page => params[:page], :per_page => 20)
  end

  def edit
    @news = News.find(params[:id])
    @tags = NewsTag.all
  end

  def new
    @news = News.new
    @tags = NewsTag.all
  end

  def create
    @news = News.new(news_param)
    if @news.save
      create_news_tags(@news, params)
      flash[:notice] = "Create success"      
    else
      flash[:error] = "Create fail!"
    end
    redirect_to edit_admin_news_path(@news)
  end

  def update
    @news = News.find(params[:id])
    if @news.update(news_param)
      create_news_tags(@news, params)
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
    params.require(:news).permit(:title,:content,:pic,:sort,:sort_en,:is_tw,:is_en,:release_date)
  end

  def create_news_tags(news, params)
    NewsTagsRelation.delete_all(news_id: news.id)
    params[:news_tag].split(",").each do |tag_id|
      NewsTagsRelation.create(news_id: news.id, news_tag_id: tag_id)
    end
  end

end
