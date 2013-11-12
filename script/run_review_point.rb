book = Book.new(isbn: '9784813012788')
horse = RaceHorse.new(book: book)
review = ReviewPoint.new(race_horse: horse)
review.calc_point()
puts "review_count = #{review.review_count}"
puts "review_average = #{review.review_average}"
