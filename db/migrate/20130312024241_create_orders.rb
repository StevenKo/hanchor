class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :shipping_address
      t.string :billing_address
      t.string :receiver
      t.string :phone
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.integer :user_id
      t.integer :shipping_cost_id
      t.string :shipping_name
      t.string :shipping_store
      t.integer :total
      t.text :memo
      t.string :payment
      t.string :bank
      t.string :status

      t.timestamps
    end
    add_index :orders, :user_id
    add_index :orders, :shipping_cost_id
  end
end
