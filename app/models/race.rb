class Race < ActiveRecord::Base

  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}

  has_many :race_horses, :dependent => :destroy
  has_many :voting_cards, :dependent => :destroy 
  belongs_to :genre
 
end
