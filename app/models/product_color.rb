class ProductColor < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :color,:color_en

  scope :not_deleted, -> {where('is_delete != true')}

  def locale_color language
    ["zh-TW","zh"].include?( language )? color : color_en
  end
end
