class NewsTag < ActiveRecord::Base
  has_many :news_tags_relations
  has_many :news, :through => :news_tags_relations
end
