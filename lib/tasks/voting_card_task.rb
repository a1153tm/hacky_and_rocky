require 'date'
require './app/models/voting_card'

class VotingCardTask
  
  def self.execute
    puts "#{Time.now} VotingCardTask started."
    task_payback
    puts "#{Time.now} VotingCardTask finished."
  end
  
  def self.task_payback
    today = Date.today.to_datetime
    #Race.find_all_by_end_date(today) do |race|
    Race.find(:all ,:conditions => ['end_date = ?', today]).each do |race|
      puts "#{race.id} race payback search start..."
      race.create_result
      race.voting_cards.find_all_by_payout(nil).each do |card|
        puts "VotingCard:#{card.id} Race:#{card.race.id} payback"
        card.payback
        puts "#{card.id} payback success"
      end
    end
  end
  
end
