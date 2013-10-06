class WelcomeController < ApplicationController

  def index
    @news = News.limit(5).select("id, title, updated_at").order("updated_at desc")
    @videos = Video.limit(2)
    @products = Product.includes(:product_infos).select_info.limit(8)
    @banners = Banner.all
  end

  def aboutus
  end

  def faq
    @faq = Faq.first
  end
end
