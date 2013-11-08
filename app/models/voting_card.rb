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
      user.point += calc_payout
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
    value = 10
    count = 1;
    race.progress.race_horses.each do |horse|
      puts horse.order
      
      puts "vote_item method check ....."
      puts horse.respond_to?("vote_item")
      puts "vote_item method check ......end"
      
      puts "vote_item.point_weight method check ....."
      puts horse.respond_to?("vote_item.point_weight")
      puts "vote_item.point_weight method check ......end"
      
      puts "odds method_check"
      puts horse.respond_to?("odds")
      puts "odds method_check .......end"
      
      #if (10 >= count) && !(horse.vote_item.nil?)
      if horse.respond_to?("vote_item")
        value += horse.odds * horse.vote_item.point_weight
      end
      puts count
      count += 1
      puts value
      puts "calc_success"
    end
    self.payout = value
  end
  
end
