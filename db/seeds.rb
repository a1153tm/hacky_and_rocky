# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Genre.delete_all
Genre.create(genre_id: 1001, name: '漫画（コミック）')
Genre.create(genre_id: 1002, name: '語学・学習参考書')
Genre.create(genre_id: 1003, name: '絵本・児童書・図鑑')
Genre.create(genre_id: 1004, name: '小説・エッセイ')
Genre.create(genre_id: 1005, name: 'パソコン・システム開発')
Genre.create(genre_id: 1006, name: 'ビジネス・経済・就職')
Genre.create(genre_id: 1007, name: '旅行・留学・アウトドア')
Genre.create(genre_id: 1008, name: '人文・思想・社会')
Genre.create(genre_id: 1009, name: 'ホビー・スポーツ・美術')
Genre.create(genre_id: 1010, name: '美容・暮らし・健康・料理')
Genre.create(genre_id: 1011, name: 'エンタメ・ゲーム')
Genre.create(genre_id: 1012, name: '科学・医学・技術')
Genre.create(genre_id: 1013, name: '写真集・タレント')
Genre.create(genre_id: 1015, name: 'その他')
Genre.create(genre_id: 1016, name: '資格・検定')
Genre.create(genre_id: 1017, name: 'ライトノベル')
Genre.create(genre_id: 1018, name: '楽譜')
Genre.create(genre_id: 1019, name: '文庫')
Genre.create(genre_id: 1020, name: '新書')
Genre.create(genre_id: 1021, name: 'ボーイズラブ（BL）')
Genre.create(genre_id: 1022, name: '付録付き')
Genre.create(genre_id: 1023, name: 'バーゲン本')
Genre.create(genre_id: 1024, name: '電子ブック')

Book.delete_all
20.times do |i|
  Book.create(title: "タイトル#{i}", author: "著者#{i}", publisher: "出版社#{i}", isbn: "ISBN#{i}")
end
