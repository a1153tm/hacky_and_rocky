class VoteItem < ActiveRecord::Base

<<<<<<< HEAD
  EXPECTATION = {10 => '◎本命' , 5 => '○対抗' , 3 =>'△穴ヒモ'}
=======
  EXPECTATION = {10 => '◎ 本命' , 5 => '◯ 対抗' , 3 =>'△ 穴ヒモ'}
>>>>>>> 4357a1042de66fe055f818b61ecd7c0d70b6587c

  belongs_to :voting_card
  belongs_to :race_horse

  validates :race_horse_id , :point_weight , presence: true
  validates_each :point_weight do |record, attr, weight|
    unless EXPECTATION.keys.include? weight.to_i
      record.errors[attr] << "任意の値を投票することはできません。"
    end
  end

end
