class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  attr_accessible :first_name, :last_name

end
