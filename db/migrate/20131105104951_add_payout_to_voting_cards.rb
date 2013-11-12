class AddPayoutToVotingCards < ActiveRecord::Migration
  def change
    add_column :voting_cards, :payout, :integer
  end
end
