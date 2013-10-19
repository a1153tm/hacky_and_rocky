class AddRaceProgressIdToRaceHorsePoints < ActiveRecord::Migration
  def change
    add_column :race_horse_points, :race_progress_id, :integer
  end
end
