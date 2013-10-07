class AddShippingToProductInfo < ActiveRecord::Migration
  def change
    add_column :product_infos, :shipping, :string
  end
end
