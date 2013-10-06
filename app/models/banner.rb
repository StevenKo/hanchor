class Banner < ActiveRecord::Base
  mount_uploader :pic, ImageUploader

end
