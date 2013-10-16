class AddSortViewsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sort, :integer, default: 0
    add_column :products, :views, :integer, default: 0
    remove_column :product_infos, :sort
    remove_column :product_infos, :views

    add_index :products, :sort
    add_index :products, :views
  end
end
