class RaceResult < ActiveRecord::Base

  belongs_to :race
  belongs_to :race_progress

  delegate :race_horses, :to => :race_progress
  #delegate :race, :to => :race_progress
  
end
