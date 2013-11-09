class User < ActiveRecord::Base

  has_many :voting_cards

end
