class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :quantity
      t.integer :price
      t.integer :product_size_id
      t.integer :product_color_id

      t.timestamps
    end
  end
end
