class VoteItem < ActiveRecord::Base

  EXPECTATION = {10 => '本命' , 5 => '対抗' , 3 =>'アナ'}

  belongs_to :voting_card
  belongs_to :race_horse

  validates :race_horse_id , :point_weight , presence: true
  validates_each :point_weight do |record, attr, weight|
    unless EXPECTATION.keys.include? weight.to_i
      record.errors[attr] << "任意の値を投票することはできません。"
    end
  end

end
