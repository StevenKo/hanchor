class CreateNewsTagsRelation < ActiveRecord::Migration
  def change
    create_table :news_tags_relations do |t|
      t.integer :news_id
      t.integer :news_tag_id
    end
  end
end
