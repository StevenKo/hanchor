class AddPurposeToFaqs < ActiveRecord::Migration
  def change
    add_column :faqs, :purpose, :string
    add_index :faqs, :purpose
  end
end
