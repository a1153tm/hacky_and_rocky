class User < ActiveRecord::Base

  has_many :voting_cards
  has_many :comment
  
end
