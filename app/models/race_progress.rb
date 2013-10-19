class RaceProgress < ActiveRecord::Base

  belongs_to :race
  has_many :race_horse_points

  def calc_order
    race.race_horses.each do |h|
      point = RaceHorsePoint.new
      point.race_horse = h
      point.calc_point
      race_horse_points << point
    end
  end

  def <=>(other)
    record_date <=> other.record_date
  end

  def horse_orders
    return nil unless race_horse_points.size
    # 特異メソッドとして、RaceHorseにorder、pointを追加する
  end

end
