module Populator
  class Publishers
    def initialize
      Publisher.delete_all
    end

    def create!(q=25)
      q.times do |i|
       Publisher.create!(name: [Faker::Company.name, " publisher", i + 1].join(" "))
     end
    end

    def self.sample
      Publishers.new.create! unless Publisher.count > 0

      Publisher.all.sample
    end
  end
end