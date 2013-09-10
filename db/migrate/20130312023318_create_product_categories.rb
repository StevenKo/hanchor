class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.boolean :is_visible, default: true
      t.integer :parent_id
      t.integer :sort
      t.string :name_en

      t.timestamps
    end
    add_index :product_categories, :parent_id
  end
end
