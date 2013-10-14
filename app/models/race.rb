class Race < ActiveRecord::Base
  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}

  has_many :race_horses, :dependent => :destroy
  belongs_to :genre
  
end
