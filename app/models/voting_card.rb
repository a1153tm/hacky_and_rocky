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
  
  def payback 
    begin
      calc_payout
      user.point += payout
      VotingCard.transaction do
        user.save!
        self.save!
      end
    rescue => e
      logger.error e
    end
  end
  
  private 
  def calc_payout
    value = 0
    race.progress(:last).race_horses.each do |horse|
      if 3 >= horse.order and horse.vote_item != nil
        value += horse.odds * horse.vote_item.point_weight
      end
    end
    self.payout = value
  end
  
end
