class AddRakutenItemsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :item_code, :string
    add_column :books, :item_price, :integer
    add_column :books, :item_caption, :text
    add_column :books, :item_url, :string
    add_column :books, :sales_date, :date
  end
end
