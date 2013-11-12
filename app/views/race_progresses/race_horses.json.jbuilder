json.array!(@horses) do |horse|
  json.order horse.order
  json.point horse.point
  json.book  horse.book
end
