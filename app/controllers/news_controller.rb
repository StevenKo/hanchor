class NewsController < ApplicationController

  def index
    @news = News.locale(params[:locale]).select("news.id, title, release_date,pic").paginate(:page => params[:page], :per_page => 16).order("release_date DESC")
    @tags_selector = NewsTag.all.map{ |tag| [tag.locale(params[:locale]),tag.id]}
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @recent_news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("release_date DESC")
    @news = News.find(params[:id])
  end

  def list
    @tags_selector = NewsTag.all.map{ |tag| [tag.locale(params[:locale]),tag.id]}
    if params[:news_tag_id].present? && params[:news_tag_id] != "0"
      news_tag = NewsTag.find(params[:news_tag_id])
      @news = news_tag.news.locale(params[:locale]).select("news.id, title, release_date,pic").paginate(:page => params[:page], :per_page => 16).order("news.release_date DESC")
    else
      @news = News.locale(params[:locale]).select("id, title, release_date,pic").paginate(:page => params[:page], :per_page => 16).order("news.release_date DESC")
    end

    render "index"
  end
end
