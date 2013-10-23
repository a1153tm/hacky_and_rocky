class AddRaceHorsePointIdToRankingPoints < ActiveRecord::Migration
  def change
    add_column :ranking_points, :race_horse_point_id, :integer
  end
end
