class CreateVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_items do |t|
      t.integer :point_weight
      t.integer :voting_card_id
      t.integer :race_horse_id

      t.timestamps
    end
  end
end
