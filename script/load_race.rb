Race.transaction do
  (1..100).each do |i|
    Race.create(:name => "レース#{i}", :grade => 0, :start_date => Time.now, :end_date => Time.now, :genre_id => 116)
  end
end
