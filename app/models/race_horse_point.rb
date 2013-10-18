class RaceHorsePoint < ActiveRecord::Base

  belongs_to :race_progress
  belongs_to :race_horse

  def calc_point
  end

  def point
  end

  def <=>(other)
    point <=> other.point
  end

end
