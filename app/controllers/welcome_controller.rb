class WelcomeController < ApplicationController

  def index
    @news = News.limit(5).select("id, title, updated_at").order("updated_at desc")
    @videos = Video.limit(2)
    @products = Product.includes(:thumb).joins(:product_infos).where("product_infos.country_id = #{@country_id}").order_by_views_and_sort.select_info.limit(8)
    @banners = Banner.all
  end

  def faq
    @faq = Faq.find_by(country_id: @country_id, purpose: "faq")
  end

  def shopping_guide
    @guide = Faq.find_by(country_id: @country_id, purpose: "shopping_guide")
  end
end
