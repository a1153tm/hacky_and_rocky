class VoteItem < ActiveRecord::Base
  belongs_to :voting_card
  belongs_to :race_horse
end
