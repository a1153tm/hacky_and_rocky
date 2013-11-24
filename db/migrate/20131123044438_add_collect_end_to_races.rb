class AddCollectEndToRaces < ActiveRecord::Migration
  def change
    add_column :races, :collect_end, :timestamp
  end
end
