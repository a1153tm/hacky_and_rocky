class RemoveRaceProgressFromRaceHorsePoints < ActiveRecord::Migration
  def change
    remove_column :race_horse_points, :race_progress, :integer
  end
end
