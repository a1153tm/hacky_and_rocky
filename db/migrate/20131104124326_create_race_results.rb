class CreateRaceResults < ActiveRecord::Migration
  def change
    create_table :race_results do |t|
      t.integer :race_progress_id

      t.timestamps
    end
  end
end
