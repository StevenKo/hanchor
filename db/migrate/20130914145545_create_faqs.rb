class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.text :context
      t.integer :country_id
      t.timestamps
    end
  end
end
