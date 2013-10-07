class News < ActiveRecord::Base
  mount_uploader :pic, ImageUploader

  default_scope {order('sort DESC')}
  
  scope :locale, lambda { |locale|
    if locale == "zh-TW"
      where(is_tw: true)
    else
      where(is_en: true)
    end
  }

end
