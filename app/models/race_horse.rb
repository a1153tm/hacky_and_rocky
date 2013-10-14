class RaceHorse < ActiveRecord::Base
  belongs_to :race
  belongs_to :book
end
