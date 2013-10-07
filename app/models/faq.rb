class Faq < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :context

  def self.find_by_locale locale
    if locale == "zh-TW"
      find(1)
    else
      find(2)
    end
  end
end
