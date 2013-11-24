class AddStateToRaces < ActiveRecord::Migration
  def change
    add_column :races, :state, :string, :default => "READY"
    Race.update_all ["state = ?","READY"]
  end
end
