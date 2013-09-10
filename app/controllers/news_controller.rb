class NewsController < ApplicationController

  def index
    @news = News.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @recent_news = News.limit(4)
    @news = News.find(params[:id])
  end
end
