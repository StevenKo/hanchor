class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :no
      t.integer :product_category_id
      
      t.timestamps
    end
    add_index :products, :product_category_id
  end
end
