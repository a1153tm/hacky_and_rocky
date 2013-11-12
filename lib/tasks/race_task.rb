require 'date'
require './app/models/race'

class RaceTask

  def self.execute
    puts "#{Time.now} RaceTask started."
    update_race_progress
    payback_voting_card
    puts "#{Time.now} RaceTask finished."
  end

  def self.update_race_progress
    puts "#{Time.now} update_race_progress started."
    today = Date.today.to_datetime
    RakutenRanking.instance.clear
    Race.find(:all, conditions: ["start_date <= ? and end_date >= ?", today, today]).each do |r|
      puts "race : #{r.name}, end_date : #{r.end_date}"
      r.create_progress today
    end
    puts "#{Time.now} update_race_progress finished."
  end

  def self.payback_voting_card
    puts "#{Time.now} payback_voting_card started."
    today = Date.today.to_datetime
    Race.find(:all ,:conditions => ['end_date = ?', today]).each do |race|
      puts "race : #{r.name}, end_date : #{r.end_date}"
      race.create_result
      race.voting_cards.find_all_by_payout(nil).each do |card|
        card.payback
      end
    end
    puts "#{Time.now} payback_voting_card finished."
  end

end
