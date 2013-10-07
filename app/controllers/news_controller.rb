class NewsController < ApplicationController

  def index
    @news = News.locale(params[:locale]).paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @recent_news = News.locale(params[:locale]).limit(5)
    @news = News.find(params[:id])
  end

  def list
    @news = News.all.select("id, title, created_at")
  end
end
