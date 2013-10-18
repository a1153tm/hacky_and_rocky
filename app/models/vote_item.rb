class VoteItem < ActiveRecord::Base
  EXPECTATION = {1 => '◎　本命' , 2 => '○　対抗' , 3 =>'△　単穴', 4=>'×　ヒモ'}
  belongs_to :voting_card
  belongs_to :race_horse
  validates :voting_card_id , :race_horse_id , :point_weight , presence: true #必須
end
