class Race < ActiveRecord::Base

  has_many :race_horses, :dependent => :destroy
  has_many :voting_cards, :dependent => :destroy 
  has_many :race_progresses, :dependent => :destroy
  belongs_to :genre
  
  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}
 
  # バッチ処理から呼出される
  def create_progress(the_date)
    olds = race_progresses.select {|p| p.record_date == the_date}
    olds.each {|o| o.destroy} unless olds.empty?
    prog = RaceProgress.new(record_date: the_date)
    prog.race = self
    prog.calc_order()
    self.race_progresses << prog
    save()
  end

  def progress(the_date = :last)
    if the_date == :last
    then return race_progresses.sort.reverse.last
    else return race_progresses.find {|p| p.record_date == the_date}
    end
  end

end
