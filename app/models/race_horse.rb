class RaceHorse < ActiveRecord::Base
  belongs_to :race
  belongs_to :book
  has_many :race_horse_points
end
