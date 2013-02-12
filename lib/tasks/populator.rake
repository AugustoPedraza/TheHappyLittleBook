require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do    
    BookInventory.destroy_all
    puts "Eliminando libros existentes.."
    puts "Se han eliminado #{Book.destroy_all.count} libros."
    puts "\n"
    puts "Eliminando autores existentes.."
    puts "Se han eliminado #{Author.destroy_all.count} autores."
    
    puts "Eliminando editoriales existentes.."
    puts "Se han eliminado #{Publisher.destroy_all.count} editoriales."

    puts "\n"*3
    puts "Creando editoriales..."

    publishers_counter = ""

    10.times do |i|
      Publisher.create!(name: [Faker::Company.name, " publisher", i + 1].join(" "))
      publishers_counter << "."
      puts publishers_counter
    end
    puts "\n"
    puts "Se crearon #{publishers_counter.size} editoriales..."

    puts "\n"*3
    puts "Creando libros..."
    
    books_counter = ""

    publishers_id = Publisher.all.map(&:id)

    50.times do |i|
      Book.create!(title: [Faker::Name.name, "book", i + 1].join(" "),
          description: Faker::Lorem.sentence(rand(40..50)),
          isbn13: [rand(101..987), rand(51..87), rand(1214..8732), rand(201..987), i].join("-"),
          published_at: (DateTime.yesterday - rand(500..2000)),
          edition: rand(1..7), publisher_id: publishers_id.sample)
      books_counter << "."
      puts books_counter
    end

    puts "\n"
    puts "Se crearon #{books_counter.size} libros..."

    puts "\n"*3
    puts "Creando inventariado de libros..."

    book_inventory_counter = ""

    Book.all.each do |book|
      quantity        = rand(3..12)
      purchase_price  = rand(100.00..250.99)
      purchased_units = quantity + rand(3..5)
      sale_price      = (purchase_price * rand(0.1..0.62)) + purchase_price

      inventory_hash = {
        purchase_price:   purchase_price,
        sale_price:       sale_price,
        quantity:         quantity,
        purchased_units:  purchased_units,
        solds_units:      (purchased_units - quantity)
      }

      book.book_inventories.build(inventory_hash)
      book.save!
      book_inventory_counter << "."
      puts book_inventory_counter
    end

    books_id = Book.all.map(&:id)

    17.times do
      quantity        = rand(3..12)
      purchase_price  = rand(100.00..250.99)
      purchased_units = quantity + rand(3..5)

      inventory_hash = {
        purchase_price:   purchase_price,
        sale_price:       (purchase_price * rand(10.0..50.0)),
        quantity:         quantity,
        purchased_units:  purchased_units,
        solds_units:      (purchased_units - quantity)
      }

      book = Book.find(books_id.sample)
      book.book_inventories.build(inventory_hash)
      book.save!
      book_inventory_counter << "."
      puts book_inventory_counter
    end

    puts "\n"
    puts "Se crearon #{book_inventory_counter.size} inventarios..."

    puts "\n"*3
    puts "Creando autores..."

    autores_total = 0
    Book.all.each do |book|
      authors_counter = ""
      puts "\n"
      j = rand(1..5)
      puts "Creando #{j} autores para el libro: \"#{book.full_name}\"..."
      j.times do |i|
        book.authors.build(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
        book.save
        authors_counter << "."
        puts authors_counter
      end
      autores_total += authors_counter.length
    end

    puts "\n"
    puts "Se crearon #{autores_total.size} autores..."
  end
end