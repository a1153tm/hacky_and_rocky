class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.text :xml

      t.timestamps
    end
  end
end
