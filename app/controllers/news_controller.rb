class NewsController < ApplicationController

  def index
    @news = News.locale(params[:locale]).paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @recent_news = News.locale(params[:locale]).limit(5)
    @news = News.find(params[:id])
  end

  def list
    @recent_news = News.locale(params[:locale]).limit(5)
    if params[:news_tag_id].present?
      news_tag = NewsTag.find(params[:news_tag_id])
      @news = news_tag.news.locale(params[:locale]).select("news.id, title, created_at")
    else
      @news = News.locale(params[:locale]).select("id, title, created_at")
    end
    @tags_selector = NewsTag.all.map{ |tag| [tag.locale(params[:locale]),tag.id]}
  end
end
