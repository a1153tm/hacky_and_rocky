require './app/models/rakuten_ranking'

ranking = RakutenRanking.instance
ranking.clear
result = ranking.ranking('209261')
p result.size
p result[0]
