class NewsTag < ActiveRecord::Base
  has_many :news_tags_relations
  has_many :news, :through => :news_tags_relations

  def locale(language)
    if (["zh-TW","zh"].include? language)
      name
    else
      name_en
    end
  end
end
