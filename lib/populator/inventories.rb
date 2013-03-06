module Populator
  class Inventories
    def initialize
      BookInventory.delete_all
    end

    def create!(q=500, init_book=nil)
      q.times do |i|
        purchased_units = rand(10..30)
        solds_units     = rand(0..purchased_units)
        quantity        = (purchased_units - solds_units)

        purchase_price  = rand(70.00..120.99)
        sale_price      = ((purchase_price * rand(0.1..0.75)) + purchase_price)
        book            = init_book || Populator::Books.sample

        BookInventory.create!(purchase_price: purchase_price, sale_price: sale_price,
                            quantity: quantity, purchased_units: purchased_units,
                            solds_units: solds_units, book: book)
      end

      check_books_without_inventory
    end

  private
    def check_books_without_inventory
      books_without_inventory = Book.all.select{ |book| book.book_inventories.count == 0 }
      books_without_inventory.each do |book|
        create!(rand(1..5), book)
      end
    end
  end
end
