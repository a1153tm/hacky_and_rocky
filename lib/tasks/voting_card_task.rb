require 'date'
require './app/models/voting_card'

class VotingCardTask
  
  def self.execute
    puts "#{Time.now} VotingCardTask started."
    task_payback
    puts "#{Time.now} VotingCardTask finished."
  end
  
  def self.task_payback
=begin
    today = Date.today.to_datetime
    cards = VotingCard.find(:all, :include => :race, :conditions => ['payout IS ?' , nil])
    if cards.count > 0
     cards.each do |card|
       puts "#{Time.now} calc_payout VotingCard ID #{card.id}"
       card.payback
     end
    else
      puts "VotingCard Nothing..."
    end
=end
    puts "#{Time.now} VotingCardTask started."
    today = Date.today.to_datetime
    #Race.find_all_by_end_date(today) do |race|
    Race.all do |race|
      race.create_result
      race.voting_cards.each do |card|
        card.payback
      end
    end
    puts "#{Time.now} VotingCardTask finished."
  end
  
end