class CreateProductInfos < ActiveRecord::Migration
  def change
    create_table :product_infos do |t|
      t.string :name
      t.string :weight
      t.string :material
      t.string :capacity
      t.text :quick_overview
      t.string :dimension
      t.integer :price
      t.integer :special_price
      t.text :feature
      t.boolean :is_visible
      t.integer :views
      t.integer :sort
      t.integer :product_id
      t.integer :country_id

      t.timestamps
    end
    add_index :product_infos, :product_id
    add_index :product_infos, :country_id
  end
end
