module Populator
  class Authors
    def initialize
      #Delete FK dependencies
      ActiveRecord::Base.connection.delete("DELETE FROM authors_books")

      Author.delete_all
    end

    def create!(q=200)
      q.times do
        Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
      end
    end

    def self.sample(q=1)
      Authors.new.create! unless Author.count > 0

      Author.all.sample(q)
    end
  end
end
