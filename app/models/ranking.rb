class Ranking < ActiveRecord::Base

  BASE_URL = "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20130522"
  APPL_ID = "1055548998906694747"
  SECRET_KEY = ""

  def self.fetch
    httpClient = HTTPClient.new
    jsonData = nil
    data = httpClient.get_content(BASE_URL, {
        'applicationId' => APPL_ID,
        'booksGenreId' => '001005005006',
        'sort' => 'sales'
    })
    jsonData = JSON.parse data
    logger.debug jsonData["Items"]
    jsonData.each do |item|
      r = Ranking.new
      #r.xml = item["Item"]
      #r.save
    end
  end
end

class RankingPoint < ActiveRecord::Base
  belongs_to :race_horse_point

  def calcurate_point()
    raw_data = get_json(...) # 実際にはgenre_codeを渡す
    item = search_item(raw_data, ...)  # 実際にはitem_codeを渡す
    if item
      point = item[...] # 実際にはjsonのキーを指定する
    else
      point = 0
    end
    save()
  end

  private
    def get_json(genre_id)
      # 楽天APIを叩く
    end

    def search_item(raw_data, item_code)
      # raw_dataを検索する
    end
end


