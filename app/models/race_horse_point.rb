class RaceHorsePoint < ActiveRecord::Base
  
  belongs_to :race_progress
  belongs_to :race_horse
  has_one :ranking_point, :dependent => :destroy
  has_one :review_point, :dependent => :destroy

  def calc_point
    self.ranking_point = RankingPoint.new
    ranking_point.race_horse = race_horse
    ranking_point.calc_point()

    self.review_point = ReviewPoint.new
    review_point.race_horse = race_horse
    review_point.calc_point()
  end

  # 将来的には拡張する (レビューポイント、ツイートポイント)
  def point
    ranking_point.point + review_point.point
  end

  def <=>(other)
    point <=> other.point
  end

end
