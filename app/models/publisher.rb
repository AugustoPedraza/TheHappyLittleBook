class Publisher < ActiveRecord::Base
  has_many :books
  attr_accessible :name
end
