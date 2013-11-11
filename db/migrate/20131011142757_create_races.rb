class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.string :name
      t.integer :grade
      t.string :etype
      t.timestamp :start_date
      t.timestamp :end_date

      t.timestamps
    end
  end
end