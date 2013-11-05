class RaceResult < ActiveRecord::Base

  belongs_to :race
  #has_one :race_progress
  attr_accessor :race_progress

  def race_horses
    race_progress.race_horses
  end

end
