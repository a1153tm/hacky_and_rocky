class RaceHorse < ActiveRecord::Base
  belongs_to :book
  belongs_to :race
  has_one :vote_item
end
