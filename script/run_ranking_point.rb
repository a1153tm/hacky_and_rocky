race = Race.new(name: 'テストレース', genre: Genre.new(genre_id: 200162))
book = Book.new(item_code: 'book:16619769')
race_horse = RaceHorse.new(race: race, book: book)
ranking = RankingPoint.new
ranking.race_horse = race_horse
ranking.calc_point()
puts "point = #{ranking.point}"