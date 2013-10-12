class AddHouseNoToRaceHorse < ActiveRecord::Migration
  def change
    add_column :race_horses, :horse_no, :integer
  end
end
