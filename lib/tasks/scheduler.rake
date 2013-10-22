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
