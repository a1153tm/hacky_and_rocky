class CreateRaceHorses < ActiveRecord::Migration
  def change
    create_table :race_horses do |t|
      t.integer :house_no
      t.text :comment
      t.integer :race_id
      t.integer :book_id

      t.timestamps
    end
  end
end
