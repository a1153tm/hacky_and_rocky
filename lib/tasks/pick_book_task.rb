require './app/models/book'
require './app/models/genre'

class PickBookTask
  def self.execute(item_code = "14112185")
    #Genre.find(:all).each do |g|
      begin
        item_json = JSON.parse(get_item_json(item_code))
      rescue HTTPClient::BadResponseError => e
        p e
        #next
      end
      items = item_json['Items'].map {|i| i['Item']}
      books = items.inject([]) do |bs,i|
        b = Book.new(title: i['itemName'], item_code: i['itemCode'],
          item_price: i['itemPrice'], item_caption: i['itemCaption'],
          item_url: i['itemUrl'], genre_id: i['genreId'])
        small  = i['smallImageUrls']
        b.small_image_url  = small[0]  if small and small.size
        medium = i['mediumImageUrls']
        b.medium_image_url = medium[0] if medium and medium.size
        bs << b
      end
      begin
        limit = books.size > 100 ? 100 : books.size
        books[0...limit].each do |book|
          book.item_caption =~ /\sISBN\D+(\d{7,})\s/
          isbn = $1
          next unless isbn
          begin
            book_json = JSON.parse(get_book_json(isbn))
            p book_json
          rescue HTTPClient::BadResponseError => e
            p e
            #next
          end
          if book_json['count']
            hash = book_json['Items'][0]['Item']
            book.title = hash['title']
            book.item_caption = hash['itemCaption']
            book.isbn = hash['isbn']
            book.author = hash['author']
            book.publisher = hash['publisherName']
            book.books_genre_id = hash['booksGenreId']
            book.sales_date = hash['salesDate']
            book.small_image_url  = hash['smallImageUrl']
            book.medium_image_url = hash['mediumImageUrl']
            book.large_image_url  = hash['largeImageUrl']
            Book.transaction do
              if _book = Book.find_by_isbn(book.isbn) || Book.find_by_title(book.title)
                _book.destroy()
              end
              book.save()
            end
          end
        end
      rescue NoMethodError => e
        p e
      end
    #end
  end

  private

  ITEM_URL = "https://app.rakuten.co.jp/services/api/IchibaItem/Search/20130805"
  BOOK_URL = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20130522"
  APPL_ID = "1040009963818982878"

  def self.get_item_json(item_code)
    HTTPClient.new.get_content(ITEM_URL, {
      'applicationId' => APPL_ID,
      #'genreId' => genre_id,
      'itemCode' => "book:" + item_code.to_s,
    })
  end

  def self.get_book_json(isbn)
    HTTPClient.new.get_content(BOOK_URL, {
      'applicationId' => APPL_ID,
      'isbn' => isbn,
    })
  end
end

