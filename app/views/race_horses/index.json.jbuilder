json.array!(@race_horses) do |race_horse|
  json.extract! race_horse, :horse_no, :comment, :race_id, :book_id
  json.url race_horse_url(race_horse, format: :json)
end
