desc "This task is called by the Heroku scheduler add-on"

task :update_race_progress => :environment do
  puts "#{Time.now} RaceTask started."
  today = Date.today.to_datetime
  Race.find(:all, conditions: ["start_date <= ? and end_date >= ?", today, today]).each do |r|
    puts "race : #{r.name}, end_date : #{r.end_date}"
    r.create_progress today
  end
  puts "#{Time.now} RaceTask finished."
end

task :payback_voting_card => :enviroment do
  puts "#{Time.now} VotingCardTask started."
  today = Date.today.to_datetime
  cards = VotingCard.find(:all, :include => :race, :conditions => ['? = races.end_date AND payout IS ?' , today, nil])
    cards.each do |card|
      puts "#{Time.now} calc_payout VotingCard ID #{card.id}"
      card.payback
    end
  puts "#{Time.now} VotingCardTask finished."
end

Rake::Task[:payback_voting_card].enhance([:update_race_progress]) do
  Rake::Task[:update_race_progress].invoke
end
