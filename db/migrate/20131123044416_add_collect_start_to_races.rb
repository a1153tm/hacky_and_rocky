class AddCollectStartToRaces < ActiveRecord::Migration
  def change
    add_column :races, :collect_start, :timestamp
  end
end
