class ReviewPoint < ActiveRecord::Base

  BASE_URL = 'https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522'
  APPL_ID = '1040009963818982878'

  attr_accessor :race_horse

  def calc_point
    json = JSON.parse(get_json(@race_horse.book.isbn))
    items = json['Items']
    if items and !items.empty?
      item = items[0]['Item']
      self.review_count = item['reviewCount']
      self.review_average = item['reviewAverage']
    end
  end

  def point
    @point ||= (review_count * review_average * 100).to_i
  end
  
  def get_json(isbn)
    sleep 1
    httpClient = HTTPClient.new
    httpClient.get_content(BASE_URL, {
      'format' => 'json',
      'applicationId' => APPL_ID,
      'isbn' => isbn
    })
  end

end
