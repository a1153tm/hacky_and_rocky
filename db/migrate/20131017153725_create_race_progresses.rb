class CreateRaceProgresses < ActiveRecord::Migration
  def change
    create_table :race_progresses do |t|
      t.date :record_date
      t.integer :race_id

      t.timestamps
    end
  end
end
