require 'singleton'

class RakutenRanking
  # シングルトンオブジェクト
  include Singleton

  BASE_URL = 'https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927'
  APPL_ID = '1040009963818982878'
  #APPL_ID = '1055548998906694747'
  #AFFI_ID = '11b5cf1c.5f32ac57.11b5cf1d.b23d0e32'

  def clear
    @rankings = {}
  end

  def ranking(genre_id)
    ranking = @rankings[genre_id]
    return ranking if ranking
    ranking = []
    (1...34).each do |i|
      items = JSON.parse(get_json(genre_id, i))
      if items['Items'].empty?
      then break
      else ranking += items['Items']
      end
    end
    @rankings[genre_id] = ranking
    ranking
  end

  private

  def get_json(genre_id, i)
    sleep 1
    httpClient = HTTPClient.new
    httpClient.get_content(BASE_URL, {
      'applicationId' => APPL_ID,
      #'affiliateId'   => AFFI_ID,
      'genreId' => genre_id,
      'page' => i.to_s
    })
  end

end
