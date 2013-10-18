class RaceProgress < ActiveRecord::Base
  belongs_to :race
  has_many :race_horse_points
end
