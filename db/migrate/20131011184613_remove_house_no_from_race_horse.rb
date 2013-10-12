class RemoveHouseNoFromRaceHorse < ActiveRecord::Migration
  def change
    remove_column :race_horses, :house_no, :integer
  end
end
