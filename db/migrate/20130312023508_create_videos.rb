class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :link
      t.text :intro
      t.integer :sort

      t.timestamps
    end
  end
end
