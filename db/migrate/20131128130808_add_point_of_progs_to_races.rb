class AddPointOfProgsToRaces < ActiveRecord::Migration
  def change
    add_column :races, :point_of_progs, :integer
  end
end
