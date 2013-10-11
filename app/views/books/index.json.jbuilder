json.array!(@books) do |book|
  json.extract! book, :title, :author, :publisher, :isbn
  json.url book_url(book, format: :json)
end
