require './app/models/race'

class RaceTask
  def self.execute
    print "#{Time.now} Executed Race.testing\n"
    Race.testing
  end
end
