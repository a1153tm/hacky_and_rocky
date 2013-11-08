class RaceProgress < ActiveRecord::Base

  belongs_to :race
  has_many :race_horse_points, :dependent => :destroy

  def calc_order
    race.race_horses.each do |h|
      point = RaceHorsePoint.new
      point.race_horse = h
      sleep 0.1
      point.calc_point()
      race_horse_points << point
    end
  end
  
  def <=>(other)
    record_date <=> other.record_date
  end

  def race_horses
    return nil if race_horse_points.nil? or race_horse_points.empty?
    # 特異メソッドとして、RaceHorseにorder、pointを追加する
    horses = []
    race_horse_points.sort.reverse.each_with_index do |p,i|
      horse = p.race_horse
      # 順位、ポイントを取得する特異メソッドを追加する
      class << horse
        attr_accessor :order, :point
      end
      horse.order = i + 1
      horse.point = p.point
      logger.debug horse.book.title
      horses << horse
    end
    horses
  end

end
