require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.hanchor.com'
SitemapGenerator::Sitemap.create_index = :auto
SitemapGenerator::Sitemap.create do
  add '/aboutus', :changefreq => 'monthly'
  add '/news',  :changefreq => 'daily'
  add '/products/packing',  :changefreq => 'daily'
  add '/products/accessories',  :changefreq => 'daily'
  add '/products/apparel',  :changefreq => 'daily'
  add '/products/others',  :changefreq => 'daily'
  add '/products/customization',  :changefreq => 'daily'
  add '/products/deal', :changefreq => 'daily'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
