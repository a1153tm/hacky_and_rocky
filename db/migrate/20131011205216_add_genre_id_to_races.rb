class AddGenreIdToRaces < ActiveRecord::Migration
  def change
    add_column :races, :genre_id, :integer
  end
end
