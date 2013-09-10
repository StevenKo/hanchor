class CreateShippingCosts < ActiveRecord::Migration
  def change
    create_table :shipping_costs do |t|
      t.integer :cost
      t.string :description
      t.integer :country_id

      t.timestamps
    end
    add_index :shipping_costs, :country_id
  end
end
