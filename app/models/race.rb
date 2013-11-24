class Race < ActiveRecord::Base

  has_many :race_horses, :dependent => :destroy
  has_many :voting_cards, :dependent => :destroy 
  has_many :race_progresses, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_one  :race_result, :dependent => :destroy
  belongs_to :genre
  belongs_to :current_progress, foreign_key: "current_progress_id", class_name: "RaceProgress"
  
  validates :name, :start_date, :end_date, :genre_id,  presence: true
  validates :name, length: {minimum: 3, maximum: 20}
  validates_each :race_horses do |record, attr, horses|
    unless horses.size == 10
      record.errors[attr] << "本を10冊登録してください。"
    end
  end
  validates_each :state do |record, attr, state|
    unless STATES.include? state
      record.errors[attr] << " must in #{STATES.join(', ')}."
    end
  end

  GRADES = {1 => 'GⅠ', 2 => 'GⅡ', 3 => 'GⅢ'}
  STATES = %w{ READY RUNNING END }

  # バッチ処理として呼出される
  def create_progress(the_date)
    olds = race_progresses.select {|p| p.record_date == the_date}
    olds.each {|o| o.destroy} unless olds.empty?
    prog = RaceProgress.new(record_date: the_date)
    prog.race = self
    prog.calc_order()
    self.race_progresses << prog
    save!
  end

  def progress(the_date = :last)
    if the_date == :current
      if current_progress
      then return current_progress
      else return RaceProgress.new(race: self)
      end
    elsif the_date == :last
      return race_progresses.sort.last
    else
      return race_progresses.find {|p| p.record_date == the_date}
    end
  end

  def create_result()
    self.race_result = RaceResult.new(race_progress: progress(:current), race: self)
    # レース状態をRUNNING → ENDに変更する
    self.state = 'END'
    save!
  end

  # バッチ処理として呼出される
  def start
    puts "race start: {name: #{name}, start_date: #{start_date}, end_date: #{end_date}}"

    # レース状態をREADY → RUNNINGに変更する
    state = "RUNNING"
    # 蓄積されている経過状況を、record_dateでソートして取得する
    progs = race_progresses.sort
    # 更新頻度を計算する
    interval = (end_date - start_date) / progs.size.to_f
    # レース経過を計算した頻度でスイッチする
    progs.each_with_index do |prog, i|
      self.current_progress = prog
      save!
      sleep interval
    end
    # レースを終了(確定)する
    create_result()
    # 払い戻す
    voting_cards.each {|card| card.payback()}

    puts "race end:   {name: #{name}, start_date: #{start_date}, end_date: #{end_date}}"
  end

  # for testing
  def _result
    result = RaceResult.new
    prog = progress(:last)
    result.race_progress = prog
    result.race = self
    result
  end

end
