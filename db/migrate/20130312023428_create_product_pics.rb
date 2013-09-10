class CreateProductPics < ActiveRecord::Migration
  def change
    create_table :product_pics do |t|
      t.integer :product_id
      t.string :description
      t.string :pic
      t.integer :sort

      t.timestamps
    end
    add_index :product_pics, :product_id
  end
end
