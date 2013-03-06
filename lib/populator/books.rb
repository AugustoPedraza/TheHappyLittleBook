module Populator
  class Books
    def initialize
      #Delete FK dependencies
      BookInventory.delete_all
      CartItem.delete_all
      Cart.delete_all
      ActiveRecord::Base.connection.delete("DELETE FROM authors_books")

      Book.delete_all
    end

    def create!(q=100)
      q.times do |i|
        title        = [Faker::Name.name, "book", i + 1].join(" ")
        description  = Faker::Lorem.sentence(rand(40..50))
        isbn13       = [rand(101..987), rand(51..87), rand(1214..8732), rand(201..987), i].join("-")
        published_at = (DateTime.yesterday - rand(500..2000))
        edition      = rand(1..7)

        book =  Book.create!( title: title, description: description, isbn13: isbn13,
                      published_at: published_at, edition: edition,
                      publisher: Populator::Publisers.sample
                     )

        book.authors << Populator::Authors.sample(rand(1..5))
        book.save
      end
    end

    def self.sample(q=1)
      Books.new.create! unless Book.count > 0

      Book.all.sample
    end
  end
end
