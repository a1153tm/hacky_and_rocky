class RaceProgress < ActiveRecord::Base

  belongs_to :race
  has_many :race_horse_points, :dependent => :destroy

  def calc_order
    race.race_horses.each do |h|
      point = RaceHorsePoint.new
      point.race_horse = h
      point.calc_point()
      race_horse_points << point
    end
  end
  
  def <=>(other)
    record_date <=> other.record_date
  end

  def race_horses
    # Monkey patching
    if race_horse_points.nil? or race_horse_points.empty?
      race.race_horses.each do |horse|
        point = RaceHorsePoint.new(race_horse: horse)
        point.instance_eval do
          def point; 0; end
        end
        self.race_horse_points << point
      end
    end
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
      horses << horse
    end
    horses
  end

end
