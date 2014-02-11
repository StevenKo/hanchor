class AddIsDeleteToColorAndSize < ActiveRecord::Migration
  def change
    add_column :product_colors, :is_delete, :boolean, default: false
    add_column :product_sizes, :is_delete, :boolean, default: false
  end
end
