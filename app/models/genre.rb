class Genre < ActiveRecord::Base
  has_many :races
  has_many :books

  def self.get_all
    json_data = JSON.parse(get_json)
    second_level_items = json_data['children'].map {|c| c['child']}

    Genre.transaction do
      Genre.delete_all
      second_level_items.each do |item|
        Genre.create(genre_id: item['genreId'], name: item['genreName'])
      end
    end
  end

  private

  BASE_URL = "https://app.rakuten.co.jp/services/api/IchibaGenre/Search/20120723"
  APPL_ID = "1055548998906694747"

  def self.get_json
    HTTPClient.new.get_content(BASE_URL, {
      'applicationId' => APPL_ID,
      'genreId' => '200162',
    })
  end
end
