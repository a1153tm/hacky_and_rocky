require 'date'
require './app/models/race'

class RaceTask

  def self.execute
    puts "#{Time.now} RaceTask started."
    calc_point
    puts "#{Time.now} RaceTask finished."
  end

  def self.calc_point
    today = Date.today.to_datetime
    Race.find(:all, conditions: ["start_date <= ? and end_date >= ?", today, today]).each do |r|
      puts "race : #{r.name}, end_date : #{r.end_date}"
      r.create_progress today
    end
  end

end
