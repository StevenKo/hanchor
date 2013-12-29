class AddSlugToUserAndProduct < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
    add_index :products, :slug

    Product.all.each do |p|
      p.update_attribute(:slug, p.product_infos[1].name.to_slug)
    end
  end
end
