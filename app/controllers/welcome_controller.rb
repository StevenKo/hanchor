class WelcomeController < ApplicationController

  def index
    @news = News.all
    @videos = Video.limit(2)
    @products = ProductInfo.joins(:product).limit(2)
  end

  def aboutus
  end
end
