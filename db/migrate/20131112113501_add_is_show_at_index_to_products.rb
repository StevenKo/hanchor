class AddIsShowAtIndexToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_show_at_index, :boolean, default: false
  end
end
