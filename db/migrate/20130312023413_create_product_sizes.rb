class CreateProductSizes < ActiveRecord::Migration
  def change
    create_table :product_sizes do |t|
      t.integer :product_id
      t.string :size
      t.string :size_en

      t.timestamps
    end
    add_index :product_sizes, :product_id
  end
end
