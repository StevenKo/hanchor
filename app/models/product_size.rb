class ProductSize < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :size,:size_en

  scope :not_deleted, -> {where('is_delete != true')}

  def locale_size language
    ["zh-TW","zh"].include?( language )? size : size_en
  end
end
