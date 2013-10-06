class AddDum2ToDummies < ActiveRecord::Migration
  def change
    add_column :dummies, :dum2, :integer
  end
end
