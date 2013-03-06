module Populator
  class Users
    def initialize
      #Delete FK dependencies
      ActiveRecord::Base.connection.delete("DELETE FROM users_roles")

      User.delete_all
    end

    def create!(users_with_role, default_pass='asdasd')
      users_with_role.each do |username, role|
        hash = {
          name:                  username,
          email:                 (username.gsub(/\s+/, '') << "@thlbook.com"),
          password:              default_pass,
          password_confirmation: default_pass
        }

        new_user = User.new(hash)
        new_user.add_role(role) if role
        new_user.save!
      end
    end

    def self.sample(q=1)
      Users.new.create! unless User.count > 0

      User.all.sample(q)
    end
  end
end
