class AddCollectStartToRaces < ActiveRecord::Migration
  def change
    add_column :races, :collect_start, :timestamp
    Race.update_all ["collect_start = ?", Time.now]
  end
end
