require './app/models/genre'

class GenreTask
  def self.execute
    Genre.get_all
  end
end
