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
    puts Race.find(:all, conditions: ["start_date >= ? and end_date <= ?", today, today]).size
  end
end
