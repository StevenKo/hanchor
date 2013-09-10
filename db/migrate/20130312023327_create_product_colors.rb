class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|
      t.integer :product_id
      t.string :color
      t.string :color_en

      t.timestamps
    end
    add_index :product_colors, :product_id
  end
end
