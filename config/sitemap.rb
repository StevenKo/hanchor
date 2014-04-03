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
  add '/shopping_guide', :changefreq => 'daily'
  add '/products/Packing/PIPE_-T1', :changefreq => 'daily', :priority => 0.9
  add '/products/SUL%20Series/ASH-SUL27_Backpack', :changefreq => 'daily'
  add '/products/SUL%20Series/ASH-SUL39_Backpack', :changefreq => 'daily'
  add '/products/Urban%20Climbing%20Series/KANGAROO', :changefreq => 'daily', :priority => 0.9
  add '/products/Urban%20Climbing%20Series/HULA', :changefreq => 'daily', :priority => 0.9
  add '/products/Commuter%20Series/Messenger_Bag_SCHIST_Small', :changefreq => 'daily'
  add '/products/Commuter%20Series/Messenger_Bag_SCHIST', :changefreq => 'daily'
  add '/products/Packing/Shoulder_Bag_SLATE', :changefreq => 'daily'
  add '/products/accessories/MICA', :changefreq => 'daily'
  add '/products/accessories/RIPPLE', :changefreq => 'daily'
  add '/products/accessories/GRANULE', :changefreq => 'daily'
  add '/products/accessories/Flat_Pouch', :changefreq => 'daily'
  add '/products/accessories/Ultrabook_Sleeve', :changefreq => 'daily'
  add '/products/accessories/Tablet_Sleeve', :changefreq => 'daily'
  add '/products/accessories/Stationery_Pocket', :changefreq => 'daily'
  add '/accessories/Pocket_L', :changefreq => 'daily'
  add '/accessories/Pocket_M', :changefreq => 'daily'
  add '/apparel/HANCHOR_LOGO_TSHIRT_Grey', :changefreq => 'daily'
  add '/apparel/HANCHOR_LOGO_TSHIRT_white', :changefreq => 'daily'
  add '/others/OTTOMAN_ROPE_CLIP', :changefreq => 'daily'
  add '/others/Two_strike_Delivery_within_Taiwan', :changefreq => 'daily'
  add '/others/HANCHOR_SUL_Sleeping_Pad_half_Delivery_within_Taiwan', :changefreq => 'daily'
  add '/others/HANCHOR_SUL_Sleeping_Pad_full_Delivery_within_Taiwan', :changefreq => 'daily'
  add '/others/Rock_Climbing_Taiwan_Guidebook', :changefreq => 'daily'
  add '/products/customization/Custom_COBBLE', :changefreq => 'daily'
  add '/products/customization/Custom_GRANULE', :changefreq => 'daily'
  add '/products/customization/Custom_PIPE', :changefreq => 'daily'
  add '/products/customization/Custom_MOAI', :changefreq => 'daily'
  add '/products/customization/Custom_DUOSCHIST', :changefreq => 'daily'
  add '/products/customization/Custom_DUOSCHIST_Small', :changefreq => 'daily'
  add '/products/customization/Custom_CHAMBER_MINI', :changefreq => 'daily'
  add '/products/customization/Custom_SLATE', :changefreq => 'daily'
  add '/products/deal/iPhone_Sleeve_special_edition', :changefreq => 'daily'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks
