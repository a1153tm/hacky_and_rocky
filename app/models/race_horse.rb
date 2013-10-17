class RaceHorse < ActiveRecord::Base
  belongs_to :race
  belongs_to :book
  has_one :vote_item
end
