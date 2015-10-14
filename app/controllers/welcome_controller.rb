class WelcomeController < ApplicationController

  def index
    @news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("news.release_date DESC")
    @videos = Video.limit(2)
    @products = Product.includes(:thumb).joins(:product_infos).where("product_infos.country_id = #{@country_id} and is_show_at_index = true").order_by_views_and_sort.select_info
    @banners = Banner.order("sort DESC")
  end

  def faq
    @faq = Faq.find_by(country_id: @country_id, purpose: "faq")
    redirect_to :shopping_guide if @country_id == 2
  end

  def shopping_guide
    @guide = Faq.find_by(country_id: @country_id, purpose: "shopping_guide")
  end
end
