require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.hanchor.com'
SitemapGenerator::Sitemap.create_index = :auto
SitemapGenerator::Sitemap.create do
  add '/aboutus', :changefreq => 'monthly'
  add '/news',  :changefreq => 'monthly', :priority => 0.7
  add '/products/packing',  :changefreq => 'monthly', :priority => 0.7
  add '/products/accessories',  :changefreq => 'monthly', :priority => 0.7
  add '/products/apparel',  :changefreq => 'monthly', :priority => 0.7
  add '/products/others',  :changefreq => 'monthly', :priority => 0.7
  add '/products/customization',  :changefreq => 'monthly', :priority => 0.7
  add '/shopping_guide', :changefreq => 'monthly'
  News.find_each do |news|
    add news_path(news), lastmod: news.updated_at, changefreq: 'monthly'
  end

  Product.find_each do |product|
    add products_show_path(product.product_category.name_en,product) if product.product_category.present?
  end

end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
