require 'date'
require './app/models/voting_card'

class VotingCardTask
  
  def self.execute
    puts "#{Time.now} VotingCardTask started."
    payback
    puts "#{Time.now} VotingCardTask finished."
  end
  
  def self.payback
    today = Date.today.to_datetime
    cards = VotingCard.find(:all, :include => :race, :conditions => ['? = races.end_date AND payout IS ?' , today, nil])
    cards.each do |card|
      puts "#{Time.now} calc_payout VotingCard ID #{card.id}"
      card.payback
    end
  end
  
end