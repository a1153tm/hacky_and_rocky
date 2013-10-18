class CreateRaceHorsePoints < ActiveRecord::Migration
  def change
    create_table :race_horse_points do |t|
      t.integer :race_progress
      t.integer :race_horse_id

      t.timestamps
    end
  end
end
