class News < ActiveRecord::Base
  mount_uploader :pic, ImageUploader

  has_many :news_tags_relations
  has_many :tags, :through => :news_tags_relations
  default_scope {order('sort DESC')}
  
  scope :locale, lambda { |locale|
    if (["zh-TW","zh"].include? locale)
      where(is_tw: true)
    else
      where(is_en: true)
    end
  }

end
