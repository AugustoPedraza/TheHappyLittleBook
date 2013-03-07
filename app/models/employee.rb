class Employee < ActiveRecord::Base
  attr_accessible :birth_date, :cuil, :first_name, :join_date, :last_name, :married, :unjoin_date

  validates :first_name, :last_name, :birth_date, :join_date, :unjoin_date, presence: true

  validates :cuil, presence: true, uniqueness: true
  validates :cuil, format: { :with => /\s*\d{2}-\d{8}-\d{1}\s*/,
    :message => "El formato del cuil debe ser: xx-xxxxxxxx-xx" }
end
