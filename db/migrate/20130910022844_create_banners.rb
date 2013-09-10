class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :pic
      t.string :link
      t.integer :sort
      t.timestamps
    end
  end
end
