class News < ActiveRecord::Base
  mount_uploader :pic, ImageUploader
end
