class ChangeProductInfoDefaultValue < ActiveRecord::Migration
  def change
    change_column :product_infos, :views, :integer, default: 0
    change_column :product_infos, :sort, :integer, default: 0
    change_column :product_infos, :is_visible, :boolean, default: false
    
    ProductInfo.all.select("id, views, sort, is_visible").each do |info|
      info.update_attributes(views: 0, sort: 0, is_visible: false)
    end

  end
end
