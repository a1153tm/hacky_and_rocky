class AddNumOfProgsToRaces < ActiveRecord::Migration
  def change
    add_column :races, :num_of_progs, :integer
  end
end
