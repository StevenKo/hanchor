class AddIsShowToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_show, :boolean
    Order.update_all("is_show = true")
  end
end
