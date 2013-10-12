class Race < ActiveRecord::Base
  has_many :race_horses
  has_many :voting_cards
end
