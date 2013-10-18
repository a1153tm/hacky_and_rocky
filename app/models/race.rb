class Race < ActiveRecord::Base

  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}

  has_many :race_horses, :dependent => :destroy
  has_many :race_progresses, :dependent => :destroy
  belongs_to :genre
  
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

end
