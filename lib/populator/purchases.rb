module Populator
  class Purchases
    def initialize
      Cart.purchases.destroy_all
    end

    def create!(q=nil)
      q ||= rand(1..55)

      q.times do |i|
        #Create cart
        cart = Cart.new
        cart.save!

        rand(5..20).times do |j|
          book = Populator::Books.sample
          last_inventory = book.book_inventories.last
          price = last_inventory ? last_inventory.purchase_price : random(79.43..131.57)

          item_hash = {
            quantity:      rand(1..10),
            price:         price + 1,
            book:          book
          }

          cart.cart_items.build(item_hash)
        end
        cart.is_purchase   = true
        cart.purchase_date = (DateTime.now - rand(50..200))
        cart.provider      = Populator::Providers.sample.first
        cart.make_purchase
      end
    end
  end
end
