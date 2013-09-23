class CreateProductQuantities < ActiveRecord::Migration
  def change
    create_table :product_quantities do |t|
      t.integer :product_id
      t.integer :product_color_id
      t.integer :product_size_id
      t.integer :quantity, default: 0

      t.timestamps
    end
    add_index :product_quantities, :product_id
    add_index :product_quantities, :product_color_id
    add_index :product_quantities, :product_size_id
  end
end
