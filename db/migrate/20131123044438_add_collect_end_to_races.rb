class AddCollectEndToRaces < ActiveRecord::Migration
  def change
    add_column :races, :collect_end, :timestamp
    Race.update_all ["collect_end = ?", Time.now]
  end
end
