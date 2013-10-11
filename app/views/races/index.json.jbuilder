json.array!(@races) do |race|
  json.extract! race, :name, :grade, :etype, :start_date, :end_date
  json.url race_url(race, format: :json)
end
