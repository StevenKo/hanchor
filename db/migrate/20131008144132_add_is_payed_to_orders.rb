class AddIsPayedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :is_payed, :boolean, default: false
  end
end
