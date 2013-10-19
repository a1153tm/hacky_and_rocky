class AddImageUrlsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :sales_date, :string
    add_column :books, :small_image_url, :string
    add_column :books, :medium_image_url, :string
    add_column :books, :large_image_url, :string
    add_column :books, :books_genre_id, :string
  end
end
