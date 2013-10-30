class AddOddsToRaceHorses < ActiveRecord::Migration
  def change
    add_column :race_horses, :odds, :float, default: 1.0
  end
end
