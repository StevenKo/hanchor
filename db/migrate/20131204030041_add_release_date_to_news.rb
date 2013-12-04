class AddReleaseDateToNews < ActiveRecord::Migration
  def change
    add_column :news, :release_date, :datetime
    add_index :news, :release_date
    News.all.each do |news|
      news.release_date = news.created_at
      news.save
    end
  end
end
