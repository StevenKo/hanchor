class NewsTagsRelation < ActiveRecord::Base
  belongs_to :news
  belongs_to :tag, foreign_key: :news_tag_id, class_name: "NewsTag"

  validates_uniqueness_of :news_tag_id, scope: [ :news_id ]
end
