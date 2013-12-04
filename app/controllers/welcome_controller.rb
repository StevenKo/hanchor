class WelcomeController < ApplicationController

  def index
    @news = News.locale(params[:locale]).select("news.id, title, release_date").limit(5).order("news.release_date DESC")
    @videos = Video.limit(2)
    @products = Product.includes(:thumb).joins(:product_infos).where("product_infos.country_id = #{@country_id} and is_show_at_index = true").order_by_views_and_sort.select_info.limit(8)
    @banners = Banner.all
  end

  def faq
    @faq = Faq.find_by(country_id: @country_id, purpose: "faq")
  end

  def shopping_guide
    @guide = Faq.find_by(country_id: @country_id, purpose: "shopping_guide")
  end
end
