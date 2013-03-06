module Populator
  class Roles
    def initialize
      #Delete FK dependencies
      ActiveRecord::Base.connection.delete("DELETE FROM users_roles")

      Role.delete_all
    end

    def create!(roles)
      roles.each do |role|
        Role.create!(name: role)
      end
    end

    def self.sample(q=1)
      Roles.new.create! unless Role.count > 0

      Role.all.sample(q)
    end
  end
end
