class CreateVotingCards < ActiveRecord::Migration
  def change
    create_table :voting_cards do |t|
      t.date :vote_date
      t.integer :race_id
      t.integer :user_id

      t.timestamps
    end
  end
end
