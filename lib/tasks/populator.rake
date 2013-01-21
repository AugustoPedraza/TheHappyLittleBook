require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do    
    puts "Eliminando libros existentes.."
    puts "Se han eliminado #{Book.destroy_all.count} libros."
    puts "\n"
    puts "Creando libros..."
    
    counter = ""

    50.times do |i|
      Book.create!(title: [Faker::Name.name, "book", i + 1].join(" "),
          description: Faker::Lorem.sentence(rand(40..50)),
          isbn13: [rand(101..987), rand(51..87), rand(1214..8732), rand(201..987), i].join("-"),
          published_at: (DateTime.yesterday - rand(500..2000)),
          edition: rand(1..7))
      counter << "."
      puts counter
    end

    puts "\n"
    puts "Se crearon #{counter.size} libros..."
  end
end