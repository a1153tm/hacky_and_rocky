class RaceHorsePoint < ActiveRecord::Base
  belongs_to :race_progress
  belongs_to :race_horse
end
