class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.string :product_id
      t.integer :quantity
      t.integer :price
      t.integer :cart_id
      t.integer :product_color_id
      t.integer :product_size_id

      t.timestamps
    end
    add_index :cart_items, :product_id
    add_index :cart_items, :cart_id
    add_index :cart_items, :product_color_id
    add_index :cart_items, :product_size_id
  end
end
