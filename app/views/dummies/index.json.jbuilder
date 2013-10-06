json.array!(@dummies) do |dummy|
  json.extract! dummy, :dummy
  json.url dummy_url(dummy, format: :json)
end
