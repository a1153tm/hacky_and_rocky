json.array!(@prog.race_horses) do |horse|
  json.numOfProgs @race.num_of_progs
  json.pointOfProgs @race.point_of_progs
  json.order horse.order
  json.point horse.point
  json.book  horse.book
end
