class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
  attr_accessible :first_name, :last_name

  def full_name
    [last_name, first_name].join(" ")
  end
end
