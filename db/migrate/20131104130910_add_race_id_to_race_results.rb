class AddRaceIdToRaceResults < ActiveRecord::Migration
  def change
    add_column :race_results, :race_id, :integer
  end
end
