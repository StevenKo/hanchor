class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :pic
      t.integer :sort
      t.integer :sort_en
      t.boolean :is_tw
      t.boolean :is_en

      t.timestamps
    end
  end
end
