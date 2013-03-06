module Populator
  class Providers
    def initialize
      Provider.all.each do |provider|
        Cart.purchases_by_provider(provider.id).destroy_all
      end

      Provider.delete_all
    end

    def create!(q=70)
      q.times do |i|
        provider = {
          name: Faker::Company.name,
          address: ["Calle", Faker::Name.first_name, rand(1..1700)].join(" "),
          cuit: [%w{20 21 27 33}.sample, rand(11111111..99999999), ("00".."99").to_a.sample].join("-")
        }

        Provider.create!(provider)
      end
    end

    def self.sample(q=1)
      Providers.new.create! unless Provider.count > 0

      Provider.all.sample(q)
    end
  end
end
