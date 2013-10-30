require 'httpclient'
class RankingPoint < ActiveRecord::Base
  attr_accessor :race_horse

  BASE_URL = 'https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927'
  APPL_ID = '1040009963818982878'
  AFFI_ID = '11b5cf1c.5f32ac57.11b5cf1d.b23d0e32'

  def calc_point
  	item_code = @race_horse.book.item_code
  	genre_id = @race_horse.race().genre().genre_id()
    raw_data = get_json(genre_id) # 実際にはgenre_codeを渡す
    ranking = search_item(JSON.parse(raw_data), item_code)
    if ranking != nil
      self.point = 1000 - ranking 　#1000から減算した値をセットする
    else
      self.point = 0
    end  
  end
  private
  def get_json(genre_id)
    #puts("Hello, world!")
    httpClient = HTTPClient.new
    #jsonData = nil
    httpClient.get_content(BASE_URL, {
      'applicationId' => APPL_ID,
      'affiliateId'   => AFFI_ID,
      'genreId' => genre_id
    })
  end
  def search_item(raw_data, item_code)
    # raw_dataを検索する
    raw_data.each do |item|
      p rawdata
    #  search_item = item['Item']    
    end
  end
end
