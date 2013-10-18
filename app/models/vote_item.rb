class VoteItem < ActiveRecord::Base
  belongs_to :voting_card
  belongs_to :race_horse
  validates :voting_card_id , :race_horse_id , :point_weight , presence: true #必須
end
