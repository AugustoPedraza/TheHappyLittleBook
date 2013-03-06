module Populator
  class Sales
    def initialize
      Cart.sales.destroy_all
    end

    def create!(q=nil)
      q ||= rand(1..55)

      q.times do |i|
        #Create cart
        cart = Cart.new
        cart.sale_date = (DateTime.now - rand(50..200))
        cart.save!

        rand(1..10).times do |j|
          book = Populator::Books.sample
          item_hash = {
            quantity: rand(1..10),
            price:    book.current_price,
            book:     book
          }
          cart.cart_items.build(item_hash)
          # cart.save!
        end

        cart.make_sale
      end
    end
  end
end
