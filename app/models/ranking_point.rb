require 'httpclient'
class RankingPoint < ActiveRecord::Base

  attr_accessor :race_horse

  BASE_URL = 'https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927'
  APPL_ID = '1040009963818982878'
  AFFI_ID = '11b5cf1c.5f32ac57.11b5cf1d.b23d0e32'

  def calc_point
  	item_code = @race_horse.book().item_code（）
  	genre_id = @race_horse.race().genre().genre_id()
    raw_data = get_json(genre_id) 
    ranking = search_item(JSON.parse(raw_data), item_code)
    if ranking != nil
      self.point = 1000 - ranking
    else
      self.point = 0
    end  
  end

  private

  def get_json(genre_id)
    httpClient = HTTPClient.new
    httpClient.get_content(BASE_URL, {
      'applicationId' => APPL_ID,
      'affiliateId'   => AFFI_ID,
      'genreId' => genre_id
    })
  end

  def search_item(hash, item_code)
   hash['Items'].each do |item|
      if item['Item']['itemCode'] == item_code then
        return item['Item']['rank']
      end
    end
  end

end
