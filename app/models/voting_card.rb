class VotingCard < ActiveRecord::Base

  belongs_to :race
  belongs_to :user
  has_many :vote_items, :dependent => :destroy 
  
  validates :race_id , :vote_date ,:user_id , :vote_items, presence: true
  validates_each :vote_items do |record, attr, horses|
    record.errors[attr] << "本を１つ以上選択してださい。" if horses.empty?
  end
  validates_each :vote_items do |record, attr, horses|
    weigths = horses.map {|h| h.point_weight.to_i}
    unless weigths.include? VoteItem::EXPECTATION.first[0]
      record.errors[attr] << "#{VoteItem::EXPECTATION.first[1]}を選択してください。"
    end
  end
  validates_each :vote_items do |record, attr, horses|
    weigths = horses.map {|h| h.point_weight.to_i}
    unless weigths.size == weigths.uniq.size
      record.errors[attr] << "重複して登録することはできません。"
    end
  end

  # Stub method
  def payout()
    horse = race.result.race_horses.first
    item = vote_items.select {|item| item.race_horse == horse}.first
    if item
    then horse.odds * item.point_weight
    else 0
    end
  end

end
