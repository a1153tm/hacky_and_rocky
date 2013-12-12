json.array! @race.race_horses do |horse|
	json.race horse.race
	json.book horse.book
end