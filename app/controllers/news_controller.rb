class NewsController < ApplicationController

  def index
    @news = News.locale(params[:locale]).paginate(:page => params[:page], :per_page => 5).order("release_date DESC")
    @recent_news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("release_date DESC")
  end

  def show
    @recent_news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("release_date DESC")
    @news = News.find(params[:id])
  end

  def list
    @recent_news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("release_date DESC")
    if params[:news_tag_id].present?
      news_tag = NewsTag.find(params[:news_tag_id])
      @news = news_tag.news.locale(params[:locale]).select("news.id, title, release_date").order("news.release_date DESC")
    else
      @news = News.locale(params[:locale]).select("id, title, release_date").order("news.release_date DESC")
    end
    @tags_selector = NewsTag.all.map{ |tag| [tag.locale(params[:locale]),tag.id]}
  end
end
