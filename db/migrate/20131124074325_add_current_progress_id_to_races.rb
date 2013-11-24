class AddCurrentProgressIdToRaces < ActiveRecord::Migration
  def change
    add_column :races, :current_progress_id, :integer
  end
end
