class RankingPoint < ActiveRecord::Base

  attr_accessor :race_horse

  def calc_point
    p @race_horse.race.genre.genre_id
    p @race_horse.book.item_code
    self.point = Random.new.rand(0..1000)
  end

end
