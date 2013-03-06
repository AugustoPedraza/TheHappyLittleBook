require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    puts "> Populating your database. Please wait..."
    puts "\n> *** Setting up populators."

    authors   = Populator::Authors.new
    books     = Populator::Books.new
    inventory = Populator::Inventories.new
    roles     = Populator::Roles.new
    users     = Populator::Users.new
    providers = Populator::Providers.new
    sales     = Populator::Sales.new
    purchases = Populator::Purchases.new

    puts "> *** Done!"

    puts "\n> *** Populating authors."
    authors.create!
    puts "> *** Done!"

    puts "\n> *** Populating books."
    books.create!
    puts "> *** Done!"

    puts "\n> *** Populating inventory."
    inventory.create!
    puts "> *** Done!"

    puts "\n> *** Populating roles."
    roles.create!(["admin", "user", "clerical worker", "worker"])
    puts "> *** Done!"

    puts "\n> *** Populating users."

    users_with_role = [
        ["admin", 'admin'],
        ["liquidador", 'clerical worker'],
        ["trabajador", 'worker'],
        ["comprador 1"],
        ["comprador 2"],
        ["comprador 3"],
        ["comprador 4"]
    ]

    users.create!(users_with_role)
    puts "> *** Done!"

    puts "\n> *** Populating providers."
    providers.create!
    puts "> *** Done!"

    puts "\n> *** Populating sales."
    sales.create!
    puts "> *** Done!"

    puts "\n> *** Populating purchases."
    purchases.create!
    puts "> *** Done!"

    puts "> Database Population process complete!"
  end
end