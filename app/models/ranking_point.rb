class RankingPoint < ActiveRecord::Base

  attr_accessor :race_horse

  def calc_point
    item_code = @race_horse.book.item_code
  	genre_id = @race_horse.race.genre.genre_id
    self.point = 0
    RakutenRanking.instance.ranking(genre_id).each do |item|
      if item['Item']['itemCode'] == item_code
        puts "#{@race_horse.book.title} #{item['Item']['rank']}"
        self.point = 1000 - item['Item']['rank'].to_i
        break
      end
    end
  end

end
