class Race < ActiveRecord::Base

  has_many :race_horses,     :dependent => :destroy
  has_many :voting_cards,    :dependent => :destroy 
  has_many :race_progresses, :dependent => :destroy
  belongs_to :genre
  
  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}
<<<<<<< HEAD
  has_many :race_horses, :dependent => :destroy
  has_many :voting_cards, :dependent => :destroy 
  belongs_to :genre
 
=======

  # バッチ処理から呼出される
  def create_progress(the_date)
    prog = RaceProgress.new(record_date: the_date)
    prog.race = self
    prog.calc_order
    prog.save
  end

  def last_progress
    race_progresses.sort.last
  end

>>>>>>> d2a4927dc288e46094a12548e1c61161eea19095
end
