class FamilyGroup < ActiveRecord::Base
  belongs_to :employee

  attr_accessible :birth_date, :cuil, :employee_id, :first_name, :is_son, :last_name

  validates :employee, :first_name, :last_name, :birth_date, presence: true

  validates :cuil, presence: true, uniqueness: true
  validates :cuil, format: { :with => /\s*\d{2}-\d{8}-\d{1}\s*/,
    :message => "El formato del cuil debe ser: xx-xxxxxxxx-xx" }
end
