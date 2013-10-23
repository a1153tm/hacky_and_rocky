class RankingPoint < ActiveRecord::Base

  attr_accessor :race_horse

  def calc_point
    self.point = Random.new.rand(0..1000)
  end

end
