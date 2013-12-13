json.array!(@prog.race_horses) do |horse|
  json.numOfProgs @race.num_of_progs
  json.pointOfProgs @race.point_of_progs
  json.id horse.id
  json.order horse.order
  json.point horse.point
  json.horseNo horse.horse_no
  json.color horse.horse_color
  json.book  horse.book
end
