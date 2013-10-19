class Genre < ActiveRecord::Base
  has_many :races
  has_many :books
end
