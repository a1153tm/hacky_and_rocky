json.numOfProgs @race.num_of_progs
json.pointOfProgs @race.point_of_progs
json.horses do
  json.array!(@prog.race_horses) do |horse|
    json.order horse.order
    json.point horse.point
    json.book  horse.book
  end
end
