class ProductPic < ActiveRecord::Base
  belongs_to :product
  mount_uploader :pic, ImageUploader

  before_create :default_name

  def default_name
    self.description ||= File.basename(pic.filename, '.*').titleize if pic
  end
  
end
