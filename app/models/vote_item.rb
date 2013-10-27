class VoteItem < ActiveRecord::Base
  EXPECTATION = {1 => '◎　本命' , 2 => '○　対抗' , 3 =>'△　穴ヒモ'}
  belongs_to :voting_card
  belongs_to :race_horse
  validates :race_horse_id , :point_weight , presence: true #必須
end
