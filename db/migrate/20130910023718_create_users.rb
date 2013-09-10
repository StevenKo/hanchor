class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :shipping_address
      t.string :billing_address
      t.string :receiver
      t.string :phone
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.string :avatar

      t.datetime :last_sign_in_at
      t.timestamps
    end
  end
end
