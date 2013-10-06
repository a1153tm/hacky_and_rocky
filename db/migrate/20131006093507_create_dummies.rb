class CreateDummies < ActiveRecord::Migration
  def change
    create_table :dummies do |t|
      t.string :dummy

      t.timestamps
    end
  end
end
