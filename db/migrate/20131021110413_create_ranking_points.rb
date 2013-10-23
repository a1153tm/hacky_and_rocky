class CreateRankingPoints < ActiveRecord::Migration
  def change
    create_table :ranking_points do |t|
      t.integer :point

      t.timestamps
    end
  end
end
