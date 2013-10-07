class Faq < ActiveRecord::Base
  belongs_to :country
  validates_presence_of :context
end
