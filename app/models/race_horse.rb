class RaceHorse < ActiveRecord::Base
  belongs_to :races
  belongs_to :books
end
