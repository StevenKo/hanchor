class ChangeCartItemProductIdToInteger < ActiveRecord::Migration
  def change
    change_column :cart_items, :product_id, :integer
  end
end
