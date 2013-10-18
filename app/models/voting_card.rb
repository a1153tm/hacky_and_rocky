class VotingCard < ActiveRecord::Base
  belongs_to :race
  belongs_to :user
  has_many :vote_items, :dependent => :destroy 
  
  validates :race_id , :vote_date ,:user_id , presence: true #名前は必須
end
